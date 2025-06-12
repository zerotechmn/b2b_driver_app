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

  var tabIndex = 0.obs;

  List<StationModel> _stationList = [];
  List<AddressModel> _addressList = [];

  Rx<List<StationModel>> stations = Rx<List<StationModel>>([]);
  Rx<List<AddressModel>> addresses = Rx<List<AddressModel>>([]);
  Rx<List<String>> stationServices = Rx<List<String>>([]);
  Rx<List<String>> fuelTypes = Rx<List<String>>([]);

  Rx<String> searchInput = Rx<String>("");
  Rx<String> selectedStationService = Rx<String>("");
  Rx<String> selectedFuelType = Rx<String>("");
  Rx<String> selectedProvince = Rx<String>("");
  Rx<String> selectedDistrict = Rx<String>("");

  var isLoading = false.obs;

  @override
  void onReady() {
    loadFromCache();
    searchController.addListener(() {
      setSearchInput(searchController.text);
    });
    super.onReady();
  }

  void loadFromCache() async {
    isLoading.value = true;
    await Future.wait(
      [loadStationsFromCache(), loadAddressesFromCache()].map((e) => e),
    );
    // Update the reactive variables
    stations.value = _stationList;
    addresses.value = _addressList;
    // Extract unique services from stations and removes empty string
    stationServices.value =
        _stationList
            .expand(
              (station) =>
                  (station.additionalInfo?.additionalServices ?? "").split(","),
            )
            .where((service) => service.isNotEmpty)
            .toSet()
            .toList()
          ..sort((a, b) => a.compareTo(b));
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

  // Method to set the selected province
  void setSelectedProvince(String province) {
    selectedProvince.value = province;
    onFilterChange();
  }

  // Method to set the selected district
  void setSelectedDistrict(String district) {
    selectedDistrict.value = district;
    onFilterChange();
  }

  // Set the search input and trigger filtering
  void setSearchInput(String input) {
    searchInput.value = input;
    onFilterChange();
  }

  onFilterChange() {
    // Filter stations based on search input, selected service, province, and district
    final filteredStations =
        _stationList.where((station) {
          final matchesSearch = station.name.toLowerCase().contains(
            searchInput.value.toLowerCase(),
          );
          final matchesService =
              selectedStationService.value.isEmpty ||
              (station.additionalInfo?.additionalServices ?? "")
                  .split(",")
                  .contains(selectedStationService.value);

          final matchesAddress =
              (selectedProvince.value.isEmpty ||
                  station.additionalInfo?.aimagHot == selectedProvince.value) &&
              (selectedDistrict.value.isEmpty ||
                  station.additionalInfo?.duuregSum == selectedDistrict.value);

          return matchesSearch && matchesService && matchesAddress;
        }).toList();

    stations.value = filteredStations;
    update();
  }

  loadStationsFromCache() async {
    final List<StationModel?> data = await storageService
        .readJsonList<StationModel>(
          "stations",
          (json) => StationModel.fromJson(json),
        );
    if (data.isNotEmpty) {
      _stationList = data.whereType<StationModel>().toList();
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
      _stationList = await userRepository.fetchGasStations();
    } on AppException catch (e) {
      e.showSnackbar();
    }
    // Save to cache
    if (_stationList.isEmpty) return;
    await storageService.writeJsonList<StationModel>("stations", _stationList);
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
