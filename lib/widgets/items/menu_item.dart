import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
  });

  final String title;
  final Widget? icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors(context).backgroundPrimary,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Row(
            spacing: 8,
            children: [
              if (icon != null) icon!,
              Expanded(
                child: Text(
                  title,
                  style: textTheme(
                    context,
                  ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              SvgPicture.asset(AssetConstants.chevronRightIcon),
            ],
          ),
        ),
      ),
    );
  }
}
