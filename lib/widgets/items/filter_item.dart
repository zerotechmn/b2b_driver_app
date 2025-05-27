import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: colors(context).backgroundPrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: colors(context).backgroundSecondary!,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Text(
          "Засвар",
          style: textTheme(
            context,
          ).bodyMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
