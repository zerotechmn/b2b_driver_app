import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectItem extends StatelessWidget {
  const SelectItem({
    super.key,
    required this.value,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  final String value;
  final String label;
  final bool isSelected;
  final void Function(String value) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(value);
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: colors(context).backgroundSecondary,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textTheme(
                context,
              ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
            ),
            SvgPicture.asset(
              isSelected
                  ? AssetConstants.optionActiveIcon
                  : AssetConstants.optionInactiveIcon,
            ),
          ],
        ),
      ),
    );
  }
}
