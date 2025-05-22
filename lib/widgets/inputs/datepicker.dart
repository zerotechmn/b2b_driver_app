import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/datepicker_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Datepicker extends StatelessWidget {
  const Datepicker({
    super.key,
    required this.label,
    required this.onChange,
    this.defaultValue,
  });

  final String label;
  final Function(DateTime datetime) onChange;
  final DateTime? defaultValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: colors(context).backgroundPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap:
            () => showMaterialModalBottomSheet(
              expand: false,
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: colors(context).backgroundPrimary,
              builder:
                  (context) =>
                      DatepickerBottomSheet(defaultValue: defaultValue),
            ).then((value) {
              if (value == null) {
                return;
              }
              onChange(value);
            }),
        behavior: HitTestBehavior.translucent,
        child: Row(
          spacing: 8,
          children: [
            SvgPicture.asset(
              AssetConstants.calendarIcon,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
            Text(
              defaultValue != null
                  ? DateFormat.yMd('mn_MN').format(defaultValue!)
                  : label,
              style: textTheme(context).titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color:
                    defaultValue != null
                        ? colors(context).labelPrimary
                        : colors(context).labelSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
