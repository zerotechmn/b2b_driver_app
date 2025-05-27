import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/data/models/statement_model.dart';
import 'package:b2b_driver_app/modules/main_pages/home/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/items/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AccountHistoryCard extends StatelessWidget {
  const AccountHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colors(context).backgroundPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Өнөөдөр хийсэн гүйлгээ",
            style: textTheme(context).bodySmall!.copyWith(
              color: colors(context).labelSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          GetBuilder<HomeController>(
            builder: (controller) {
              if (controller.isLoading.value) {
                return SizedBox(
                  width: double.infinity,
                  height: 137,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colors(context).primary,
                    ),
                  ),
                );
              }
              if (controller.statements.value.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors(context).backgroundSecondary,
                        ),
                        child: Center(
                          child: SvgPicture.asset(AssetConstants.uploadBoxIcon),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Танд өнөөдөр хийсэн гүйлгээ байхгүй байна",
                        style: textTheme(context).bodyMedium!.copyWith(
                          color: colors(context).labelSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              List<StatementModel> statements = controller.statements.value;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: statements.length,
                itemBuilder: (context, index) {
                  return HistoryItem(
                    historyType:
                        statements[index].statementTypeEnum == "PURCHASE"
                            ? HistoryTypes.purchase
                            : (statements[index].statementTypeEnum == "WITHDRAW"
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
        ],
      ),
    );
  }
}
