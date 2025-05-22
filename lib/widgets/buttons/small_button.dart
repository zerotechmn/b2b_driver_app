import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final bool isEnabled;
  final bool isLoading;
  final Widget? icon;
  final double? width;
  final double? height;
  final double? borderRadius;

  const SmallButton({
    super.key,
    this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    var backgroundColor = colors(context).backgroundSecondary;
    var textColor = colors(context).labelPrimary;
    var disabledTextColor = colors(context).labelSecondary;
    var disabledBackgroundColor = colors(context).backgroundSecondary;
    var overlayColor = Color.lerp(backgroundColor, textColor, 0.24);
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 41,
      child: TextButton(
        onPressed: !isEnabled ? null : onPressed,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius ?? 10),
              ),
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
                        minHeight: 18,
                        minWidth: 18,
                        maxHeight: 18,
                        maxWidth: 18,
                      ),
                      color: colors(context).labelSecondary,
                    ),
                  ]
                  : [
                    if (icon != null) icon!,
                    if (text != null)
                      Text(
                        text!,
                        style: textTheme(context).bodyMedium?.copyWith(
                          color: !isEnabled ? disabledTextColor : textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
        ),
      ),
    );
  }
}
