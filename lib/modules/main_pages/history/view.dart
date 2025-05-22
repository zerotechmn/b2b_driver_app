import 'package:b2b_driver_app/modules/main_pages/history/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:b2b_driver_app/widgets/appbars/home_appbar.dart';
import 'package:b2b_driver_app/widgets/inputs/datepicker.dart';
import 'package:b2b_driver_app/widgets/items/history_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    HistoryController controller = Get.find<HistoryController>();

    return Scaffold(
      appBar: getHomeAppBar(context, "Dulguun"),
      backgroundColor: colors(context).backgroundSecondary,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          children: [
            Row(
              spacing: 8,
              children: [
                Flexible(
                  child: Obx(
                    () => Datepicker(
                      label: "Эхлэх",
                      defaultValue: controller.startDate.value,
                      onChange:
                          (datetime) => controller.updateStartDate(datetime),
                    ),
                  ),
                ),
                Flexible(
                  child: Obx(
                    () => Datepicker(
                      label: "Дуусах",
                      defaultValue: controller.endDate.value,
                      onChange:
                          (datetime) => controller.updateEndDate(datetime),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: 87,
                    decoration: BoxDecoration(
                      color: colors(context).backgroundPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Орлого", style: textTheme(context).bodyMedium),
                        Text(
                          10000.toCurrency(),
                          style: textTheme(context).headlineMedium!.copyWith(
                            color: colors(context).success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: 87,
                    decoration: BoxDecoration(
                      color: colors(context).backgroundPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Зарлага", style: textTheme(context).bodyMedium),
                        Text(
                          10000.toCurrency(),
                          style: textTheme(context).headlineMedium!.copyWith(
                            color: colors(context).danger,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors(context).backgroundPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                spacing: 16,
                children: [
                  HistoryItem(historyType: HistoryTypes.debit),
                  HistoryItem(historyType: HistoryTypes.credit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
