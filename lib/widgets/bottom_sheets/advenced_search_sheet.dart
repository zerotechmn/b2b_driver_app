import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AdvencedSearchSheet extends StatelessWidget {
  const AdvencedSearchSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors(context).backgroundPrimary,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: SafeArea(
        top: false,
        child: Padding(padding: const EdgeInsets.all(16)),
      ),
    );
  }
}
