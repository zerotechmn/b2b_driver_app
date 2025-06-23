import 'package:b2b_driver_app/data/models/address_model.dart';
import 'package:b2b_driver_app/data/models/station_model.dart';
import 'package:b2b_driver_app/data/repositories/user_repository.dart';
import 'package:b2b_driver_app/services/storage_service.dart';
import 'package:b2b_driver_app/utils/exceptions.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class StationController extends GetxController {
  final UserRepository userRepository = UserRepository();
  final StorageService storageService = Get.find<StorageService>();

  final TextEditingController searchController = TextEditingController();
  final TextEditingController searchProvinceController =
      TextEditingController();
  final TextEditingController searchDistrictController =
      TextEditingController();

  var tabIndex = 0.obs;

  Rx<List<StationModel>> stationList = Rx<List<StationModel>>([]);
  List<AddressModel> _addressList = [];

  Rx<List<StationModel>> stations = Rx<List<StationModel>>([]);
  Rx<List<AddressModel>> addresses = Rx<List<AddressModel>>([]);
  Rx<List<String>> stationServices = Rx<List<String>>([]);
  Rx<List<StationProductModel>> stationProducts = Rx<List<StationProductModel>>(
    [],
  );

  // Address selection reactive variables
  Rx<List<AddressModel>> provinces = Rx<List<AddressModel>>([]);
  Rx<List<AddressModel>> districts = Rx<List<AddressModel>>([]);

  Rx<String> searchInput = Rx<String>("");
  Rx<String> selectedStationService = Rx<String>("");
  Rx<String> selectedProductType = Rx<String>("");

  // Updated to use codes instead of names for better filtering
  Rx<String> selectedProvinceCode = Rx<String>("");
  Rx<String> selectedDistrictCode = Rx<String>("");

  var isLoading = false.obs;

  @override
  void onReady() {
    loadFromCache();
    searchController.addListener(() {
      setSearchInput(searchController.text);
    });
    searchProvinceController.addListener(() {
      if (searchProvinceController.text.isEmpty) {
        selectedProvinceCode.value = "";
        selectedDistrictCode.value = "";
        if (searchDistrictController.text.isEmpty) {
          onFilterChange();
        }
        searchDistrictController.text = "";
      }
    });
    searchDistrictController.addListener(() {
      if (searchDistrictController.text.isEmpty) {
        selectedDistrictCode.value = "";
        onFilterChange();
      }
    });
    super.onReady();
  }

  void loadFromCache() async {
    isLoading.value = true;
    await Future.wait(
      [loadStationsFromCache(), loadAddressesFromCache()].map((e) => e),
    );
    // Update the reactive variables
    stations.value = stationList.value;
    addresses.value = _addressList;

    // Extract provinces (root level addresses)
    provinces.value =
        _addressList
            .where(
              (address) =>
                  address.children != null && address.children!.isNotEmpty,
            )
            .toList();

    // Extract unique services from stations and removes empty string
    stationServices.value =
        stationList.value
            .expand(
              (station) =>
                  (station.additionalInfo?.additionalServices ?? "").split(","),
            )
            .where((service) => service.isNotEmpty)
            .toSet()
            .toList()
          ..sort((a, b) => a.compareTo(b));

    // Extract unique station products by product code
    final productMap = <String, StationProductModel>{};
    for (final product in stationList.value.expand(
      (station) => station.products ?? [],
    )) {
      if (product.productCode.isNotEmpty) {
        productMap[product.productCode] = product;
      }
    }
    stationProducts.value =
        productMap.values.toList()
          ..sort((a, b) => a.productCode.compareTo(b.productCode));
    isLoading.value = false;
    update();
  }

  // Method to set the selected service
  void setSelectedService(String service) {
    // If the service is already selected, clear it
    if (selectedStationService.value == service) {
      selectedStationService.value = "";
      onFilterChange();
      return;
    }
    selectedStationService.value = service;
    onFilterChange();
  }

  // Updated method to handle province selection with cascading
  void onProvinceSelected(String provinceCode, String provinceName) {
    selectedProvinceCode.value = provinceCode;
    searchProvinceController.text = provinceName;

    // Find selected province and load its districts
    final selectedProvince = provinces.value.firstWhereOrNull(
      (province) => province.code == provinceCode,
    );

    if (selectedProvince != null) {
      districts.value = selectedProvince.children ?? [];
    } else {
      districts.value = [];
    }

    // Clear district selection when province changes
    selectedDistrictCode.value = "";
    searchDistrictController.clear();

    onFilterChange();
  }

  // Updated method to handle district selection
  void onDistrictSelected(String districtCode, String districtName) {
    selectedDistrictCode.value = districtCode;
    searchDistrictController.text = districtName;
    onFilterChange();
  }

  // Keep backward compatibility - these methods now use the new selection methods
  void setSelectedProvince(String province) {
    // Find province by name for backward compatibility
    final provinceModel = provinces.value.firstWhereOrNull(
      (p) => p.name == province,
    );
    if (provinceModel != null) {
      onProvinceSelected(provinceModel.code ?? "", provinceModel.name);
    }
  }

  void setSelectedDistrict(String district) {
    // Find district by name for backward compatibility
    final districtModel = districts.value.firstWhereOrNull(
      (d) => d.name == district,
    );
    if (districtModel != null) {
      onDistrictSelected(districtModel.code ?? "", districtModel.name);
    }
  }

  // Set the search input and trigger filtering
  void setSearchInput(String input) {
    searchInput.value = input;
    onFilterChange();
  }

  // Set selected product type
  void setSelectedProductType(String productType) {
    // If the fuel type is already selected, clear it
    if (selectedProductType.value == productType) {
      selectedProductType.value = "";
      onFilterChange();
      return;
    }
    selectedProductType.value = productType;
    onFilterChange();
  }

  onFilterChange() {
    // First, filter stations by location (province/district) - TOP PRIORITY
    List<StationModel> locationFilteredStations = stationList.value;

    if (selectedProvinceCode.value.isNotEmpty ||
        selectedDistrictCode.value.isNotEmpty) {
      locationFilteredStations =
          stationList.value.where((station) {
            final matchesProvince =
                selectedProvinceCode.value.isEmpty ||
                station.additionalInfo?.aimagHot == selectedProvinceCode.value;
            final matchesDistrict =
                selectedDistrictCode.value.isEmpty ||
                station.additionalInfo?.duuregSum == selectedDistrictCode.value;

            return matchesProvince && matchesDistrict;
          }).toList();
    }

    // Update available services based on location-filtered stations
    final availableServices =
        locationFilteredStations
            .expand(
              (station) =>
                  (station.additionalInfo?.additionalServices ?? "").split(","),
            )
            .where((service) => service.isNotEmpty)
            .toSet()
            .toList()
          ..sort((a, b) => a.compareTo(b));

    // Update available products based on location-filtered stations
    final productMap = <String, StationProductModel>{};
    for (final product in locationFilteredStations.expand(
      (station) => station.products ?? [],
    )) {
      if (product.productCode.isNotEmpty) {
        productMap[product.productCode] = product;
      }
    }
    final availableProducts =
        productMap.values.toList()
          ..sort((a, b) => a.productCode.compareTo(b.productCode));

    // Update the reactive lists
    stationServices.value = availableServices;
    stationProducts.value = availableProducts;

    // Clear selected service/product if they're no longer available
    if (selectedStationService.value.isNotEmpty &&
        !availableServices.contains(selectedStationService.value)) {
      selectedStationService.value = "";
    }

    if (selectedProductType.value.isNotEmpty &&
        !availableProducts.any(
          (p) => p.productCode == selectedProductType.value,
        )) {
      selectedProductType.value = "";
    }

    // Now apply all filters to get final station list
    final filteredStations =
        locationFilteredStations.where((station) {
          final matchesSearch = station.name.toLowerCase().contains(
            searchInput.value.toLowerCase(),
          );

          final matchesService =
              selectedStationService.value.isEmpty ||
              (station.additionalInfo?.additionalServices ?? "")
                  .split(",")
                  .contains(selectedStationService.value);

          final matchesFuelType =
              selectedProductType.value.isEmpty ||
              (station.products?.any(
                    (product) =>
                        product.productCode == selectedProductType.value,
                  ) ??
                  false);

          return matchesSearch && matchesService && matchesFuelType;
        }).toList();

    stations.value = filteredStations;
    update();
  }

  // Method to clear all filters
  void clearFilters() {
    searchController.clear();
    searchProvinceController.clear();
    searchDistrictController.clear();

    searchInput.value = "";
    selectedStationService.value = "";
    selectedProductType.value = "";
    selectedProvinceCode.value = "";
    selectedDistrictCode.value = "";

    districts.value = [];

    onFilterChange();
  }

  loadStationsFromCache() async {
    final List<StationModel?> data = await storageService
        .readJsonList<StationModel>(
          "stations",
          (json) => StationModel.fromJson(json),
        );
    if (data.isNotEmpty) {
      stationList.value = data.whereType<StationModel>().toList();
    }
    await fetchGasStations();
  }

  loadAddressesFromCache() async {
    final List<AddressModel?> data = await storageService
        .readJsonList<AddressModel>(
          "addresses",
          (json) => AddressModel.fromJson(json),
        );
    if (data.isNotEmpty) {
      _addressList = data.whereType<AddressModel>().toList();
    }
    await fetchAddresses();
  }

  fetchGasStations() async {
    try {
      stationList.value = await userRepository.fetchGasStations();
    } on AppException catch (e) {
      e.showSnackbar();
    }
    // Save to cache
    if (stationList.value.isEmpty) return;
    await storageService.writeJsonList<StationModel>(
      "stations",
      stationList.value,
    );
  }

  fetchAddresses() async {
    try {
      _addressList = await userRepository.fetchAddresses();
    } on AppException catch (e) {
      e.showSnackbar();
    }
    // Save to cache
    if (_addressList.isEmpty) return;
    await storageService.writeJsonList<AddressModel>("addresses", _addressList);
  }
}
