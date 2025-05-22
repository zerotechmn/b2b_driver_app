import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DragHandler extends StatelessWidget {
  const DragHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 5,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        color: colors(context).backgroundSecondary,
      ),
    );
  }
}
