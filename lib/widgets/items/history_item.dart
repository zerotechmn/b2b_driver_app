import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/data/models/statement_model.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

enum HistoryTypes { purchase, bonus, withdraw, charge }

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.historyType,
    required this.statement,
  });

  final StatementModel statement;
  final HistoryTypes historyType;

  @override
  Widget build(BuildContext context) {
    String type = "Зарлага";
    if (historyType == HistoryTypes.purchase) {
      type = "Зарлага";
    } else if (historyType == HistoryTypes.bonus) {
      type = "Бонус";
    } else if (historyType == HistoryTypes.withdraw) {
      type = "Татсан";
    } else if (historyType == HistoryTypes.charge) {
      type = "Орлого";
    }
    return SizedBox(
      width: double.infinity,
      child: Row(
        spacing: 8,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:
                  (historyType == HistoryTypes.purchase ||
                          historyType == HistoryTypes.withdraw)
                      ? Colors.red[50]
                      : Colors.green[50],
            ),
            child: SvgPicture.asset(
              (historyType == HistoryTypes.purchase ||
                      historyType == HistoryTypes.withdraw)
                  ? AssetConstants.uploadIcon
                  : AssetConstants.downloadIcon,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: textTheme(context).titleMedium),
                Text(
                  DateFormat(
                    "yyyy-MM-dd hh:mm",
                    "mn_MN",
                  ).format(statement.createdAt),
                  style: textTheme(
                    context,
                  ).bodyMedium!.copyWith(color: colors(context).labelSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "+${statement.amount.toInt().toCurrency()}",
                style: textTheme(context).titleMedium!.copyWith(
                  color:
                      (historyType == HistoryTypes.purchase ||
                              historyType == HistoryTypes.withdraw)
                          ? colors(context).danger
                          : colors(context).success,
                ),
              ),
              Text(
                statement.to.toInt().toCurrency(),
                style: textTheme(
                  context,
                ).bodyMedium!.copyWith(color: colors(context).labelSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
