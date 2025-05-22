import 'package:get/get.dart';

class HistoryController extends GetxController {
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;

  updateStartDate(date) {
    startDate.value = date;
    if (startDate.value.isAfter(endDate.value)) {
      endDate.value = date;
    }
  }

  updateEndDate(date) {
    endDate.value = date;
    if (startDate.value.isAfter(endDate.value)) {
      startDate.value = date;
    }
  }
}
