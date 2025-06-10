import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.name,
    this.isSelected = false,
    this.onTap,
  });

  final String name;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color:
          isSelected
              ? colors(context).primary
              : colors(context).backgroundPrimary,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border:
                isSelected
                    ? null
                    : Border.all(
                      width: 2,
                      color: colors(context).backgroundSecondary!,
                    ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              name,
              style: textTheme(context).bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color:
                    isSelected
                        ? colors(context).backgroundPrimary
                        : colors(context).labelPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
