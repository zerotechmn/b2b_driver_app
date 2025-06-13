import 'package:b2b_driver_app/data/models/card_model.dart';
import 'package:b2b_driver_app/data/models/statement_model.dart';
import 'package:b2b_driver_app/data/models/user_model.dart';
import 'package:b2b_driver_app/data/repositories/user_repository.dart';
import 'package:b2b_driver_app/services/storage_service.dart';
import 'package:b2b_driver_app/utils/exceptions.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class HomeController extends GetxController {
  final UserRepository userRepository = UserRepository();
  final StorageService storageService = Get.find<StorageService>();

  var showAccountPin = false.obs;
  var isLoading = true.obs;

  Rx<CardModel?> cardDetail = Rx<CardModel?>(null);
  Rx<List<StatementModel>> statements = Rx<List<StatementModel>>([]);

  @override
  void onInit() {
    super.onInit();
    fetchCardDetail();
  }

  toggleAccountPin(bool value) {
    showAccountPin.value = value;
    update();
  }

  fetchCardDetail() async {
    isLoading.value = true;
    update();
    final UserModel? user = await storageService.readJson<UserModel>(
      "user",
      (json) => UserModel.fromJson(json),
    );
    try {
      if (user != null) {
        cardDetail.value = await userRepository.fetchCardDetail(user.cardId);
        statements.value = await userRepository.fetchStatement(
          user.cardId,
          DateFormat(
            "yyyy-MM-dd",
            "mn_MN",
          ).format(DateTime.now().subtract(Duration(days: 1))),
          DateFormat("yyyy-MM-dd", "mn_MN").format(DateTime.now()),
        );
        // Order statement by date descending
        statements.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
      isLoading.value = false;
    } on AppException catch (e) {
      e.showSnackbar();
    }
    update();
  }

  getQR() {
    if (cardDetail.value?.cardNumber == null ||
        cardDetail.value!.cardNumber.isEmpty) {
      return null;
    }
    final qrCode = QrCode(2, QrErrorCorrectLevel.Q)
      ..addData(cardDetail.value?.cardNumber ?? "");
    return QrImage(qrCode);
  }
}
