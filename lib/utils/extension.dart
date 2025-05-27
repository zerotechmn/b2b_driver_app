import 'package:b2b_driver_app/utils/exceptions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DoubleUtils on int {
  String toCurrency() {
    var formatWithZeroDecimal = NumberFormat.currency(
      locale: 'mn_MN',
      symbol: '₮',
      decimalDigits: 0, // Show no decimal place
      customPattern: "#,##0'₮'",
    ).format(this);
    return formatWithZeroDecimal;
  }
}

extension HandleError on AppException {
  void showSnackbar({String title = "Уучлаарай"}) {
    Get.snackbar(title, message);
  }
}
