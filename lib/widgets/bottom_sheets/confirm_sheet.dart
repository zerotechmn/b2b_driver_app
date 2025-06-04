import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/drag_handler.dart';
import 'package:b2b_driver_app/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmSheet extends StatelessWidget {
  const ConfirmSheet({
    super.key,
    required this.title,
    required this.description,
    required this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.type = ButtonTypes.danger,
  });

  final String title;
  final String description;
  final String confirmText;
  final String? cancelText;
  final Function()? onConfirm;
  final Function()? onCancel;
  final ButtonTypes type;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors(context).backgroundPrimary,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DragHandler(),
              SizedBox(height: 16),
              Text(
                title,
                style: textTheme(
                  context,
                ).titleLarge!.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16),
              Text(
                description,
                style: textTheme(context).titleSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              Button(
                text: confirmText,
                type: type,
                onPressed: () {
                  if (onConfirm != null) {
                    onConfirm!();
                  }
                  Get.back();
                },
              ),
              if (cancelText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Button(
                    text: cancelText,
                    type: ButtonTypes.secondary,
                    onPressed: () {
                      if (onCancel != null) {
                        onCancel!();
                      }
                      Get.back();
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
