import 'package:intl/intl.dart';

extension DoubleUtils on int {
  String toCurrency() {
    var formatWithZeroDecimal = NumberFormat.currency(
      locale: 'mn_MN',
      symbol: '₮',
      decimalDigits: 0, // Show no decimal place
      customPattern: "#,##0'₮'",
    ).format(this);
    return formatWithZeroDecimal.replaceAll(',', '\'');
  }
}
