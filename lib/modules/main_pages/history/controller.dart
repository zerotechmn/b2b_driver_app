import 'package:b2b_driver_app/data/models/statement_model.dart';
import 'package:b2b_driver_app/data/models/user_model.dart';
import 'package:b2b_driver_app/data/repositories/user_repository.dart';
import 'package:b2b_driver_app/services/storage_service.dart';
import 'package:b2b_driver_app/utils/exceptions.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryController extends GetxController {
  final UserRepository userRepository = UserRepository();
  final StorageService storageService = Get.find<StorageService>();

  var startDate = DateTime.now().subtract(Duration(days: 7)).obs;
  var endDate = DateTime.now().obs;

  var totalDebit = 0.0.obs;
  var totalCredit = 0.0.obs;
  var isLoading = true.obs;

  Rx<List<StatementModel>> statements = Rx<List<StatementModel>>([]);

  @override
  void onReady() {
    super.onReady();
    fetchStatements();
  }

  updateStartDate(date) {
    startDate.value = date;
    if (startDate.value.isAfter(endDate.value)) {
      endDate.value = date;
    }
    fetchStatements();
  }

  updateEndDate(date) {
    endDate.value = date;
    if (startDate.value.isAfter(endDate.value)) {
      startDate.value = date;
    }
    fetchStatements();
  }

  fetchStatements() async {
    final UserModel? user = await storageService.readJson<UserModel>(
      "user",
      (json) => UserModel.fromJson(json),
    );
    isLoading.value = true;
    totalCredit.value = 0;
    totalDebit.value = 0;
    update();
    try {
      if (user != null) {
        statements.value = await userRepository.fetchStatement(
          user.cardId,
          DateFormat("yyyy-MM-dd", "mn_MN").format(startDate.value),
          DateFormat("yyyy-MM-dd", "mn_MN").format(endDate.value),
        );
        // Order statement by date descending
        statements.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        for (var i = 0; i < statements.value.length; i++) {
          final statement = statements.value[i];
          if (statement.statementTypeEnum == "PURCHASE" ||
              statement.statementTypeEnum == "WITHDRAW") {
            totalCredit.value += statement.amount;
          } else if (statement.statementTypeEnum == "CHARGE" ||
              statement.statementTypeEnum == "BONUS") {
            totalDebit.value += statement.amount;
          }
        }
      }
    } on AppException catch (e) {
      e.showSnackbar();
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
