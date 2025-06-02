import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/data/models/statement_model.dart';
import 'package:b2b_driver_app/modules/main_pages/history/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:b2b_driver_app/widgets/appbars/home_appbar.dart';
import 'package:b2b_driver_app/widgets/inputs/datepicker.dart';
import 'package:b2b_driver_app/widgets/items/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    HistoryController controller = Get.find<HistoryController>();

    return Scaffold(
      appBar: getHomeAppBar(context),
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
                        Obx(
                          () => Text(
                            controller.totalDebit.toInt().toCurrency(),
                            style: textTheme(context).headlineMedium!.copyWith(
                              color: colors(context).success,
                              fontWeight: FontWeight.w600,
                            ),
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
                        Obx(
                          () => Text(
                            controller.totalCredit.toInt().toCurrency(),
                            style: textTheme(context).headlineMedium!.copyWith(
                              color: colors(context).danger,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors(context).backgroundPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GetBuilder<HistoryController>(
                  builder: (controller) {
                    if (controller.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: colors(context).primary,
                        ),
                      );
                    }
                    List<StatementModel> statements =
                        controller.statements.value;
                    if (statements.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors(context).backgroundSecondary,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AssetConstants.uploadBoxIcon,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Тухайн хугацаанд хийсэн гүйлгээ байхгүй байна",
                            style: textTheme(context).bodyMedium!.copyWith(
                              color: colors(context).labelSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }
                    return ListView.separated(
                      itemCount: statements.length,
                      padding: const EdgeInsets.all(16),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return HistoryItem(
                          statement: statements[index],
                          historyType:
                              statements[index].statementTypeEnum == "PURCHASE"
                                  ? HistoryTypes.purchase
                                  : (statements[index].statementTypeEnum ==
                                          "WITHDRAW"
                                      ? HistoryTypes.withdraw
                                      : (statements[index].statementTypeEnum ==
                                              "CHARGE"
                                          ? HistoryTypes.charge
                                          : HistoryTypes.bonus)),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
