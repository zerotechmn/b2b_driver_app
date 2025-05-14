import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllowedPetrolCard extends StatelessWidget {
  const AllowedPetrolCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 51,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colors(context).backgroundPrimary,
      ),
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(AssetConstants.lockIcon),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Түгжсэн бүтээгдэхүүн",
                style: textTheme(
                  context,
                ).bodyLarge!.copyWith(color: colors(context).labelSecondary),
              ),
              Text(
                "АИ-92, АИ-95, Евро ДТ",
                style: textTheme(context).bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
