import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum HistoryTypes { debit, credit, withdraw, charge }

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.historyType});

  final HistoryTypes historyType;

  @override
  Widget build(BuildContext context) {
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
              color: Colors.red[100],
            ),
            child: SvgPicture.asset(
              AssetConstants.uploadIcon,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Орлого", style: textTheme(context).titleMedium),
                Text(
                  "2025-04-14 22:55",
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
                "+${100000.toCurrency()}",
                style: textTheme(
                  context,
                ).titleMedium!.copyWith(color: colors(context).success),
              ),
              Text(
                1500000.toCurrency(),
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
