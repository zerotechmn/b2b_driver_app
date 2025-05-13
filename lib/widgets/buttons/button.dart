import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum ButtonTypes { primary, transparent, white, danger }

class Button extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final ButtonTypes type;
  final bool isEnabled;
  final bool isLoading;
  final Widget? icon;
  final double? width;

  const Button({
    super.key,
    this.text,
    this.onPressed,
    required this.type,
    this.isEnabled = true,
    this.isLoading = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    var backgroundColor = colors(context).primary;
    var textColor = colors(context).backgroundPrimary;
    var disabledTextColor = colors(context).labelSecondary;
    var disabledBackgroundColor = colors(context).backgroundSecondary;
    var overlayColor = Color.lerp(backgroundColor, textColor, 0.24);
    return SizedBox(
      width: width ?? double.infinity,
      height: 50,
      child: TextButton(
        onPressed: !isEnabled ? null : onPressed,
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              side: BorderSide.none,
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            !isEnabled ? disabledBackgroundColor : backgroundColor,
          ),
          overlayColor: WidgetStatePropertyAll(overlayColor),
          elevation: const WidgetStatePropertyAll(0),
          shadowColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              isLoading
                  ? [
                    CircularProgressIndicator(
                      constraints: BoxConstraints(
                        minHeight: 20,
                        minWidth: 20,
                        maxHeight: 20,
                        maxWidth: 20,
                      ),
                      color: colors(context).labelSecondary,
                    ),
                  ]
                  : [
                    if (icon != null) icon!,
                    if (text != null)
                      Text(
                        text!,
                        style: textTheme(context).titleSmall?.copyWith(
                          color: !isEnabled ? disabledTextColor : textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
        ),
      ),
    );
  }
}
