import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool isReadOnly;
  final bool isEnabled;
  final bool isAutoFocus;
  final int maxLength;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool? showClearIcon;
  final Function(String)? onChanged;
  final Function()? onTap;

  const Input({
    super.key,
    this.controller,
    this.hint,
    this.focusNode,
    this.keyboardType,
    this.isPassword = false,
    this.isReadOnly = false,
    this.isEnabled = true,
    this.isAutoFocus = false,
    this.maxLength = 8,
    this.leadingIcon,
    this.trailingIcon,
    this.showClearIcon,
    this.onChanged,
    this.onTap,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool showEyeIcon = false;
  bool showClearIcon = false;

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    onValueChange();
    widget.controller?.addListener(onValueChange);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(onValueChange);
    super.dispose();
  }

  void onValueChange() {
    setState(() {
      if ((widget.showClearIcon == true &&
          widget.controller?.text.isNotEmpty == true)) {
        showClearIcon = true;
      } else {
        showClearIcon = false;
      }
      if (widget.controller?.text.isNotEmpty == true) {
        showEyeIcon = true;
      } else {
        showEyeIcon = false;
      }
    });
  }

  @override
  void didUpdateWidget(covariant Input oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      onValueChange();
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> trailingIcons = [];
    if (widget.trailingIcon != null) {
      trailingIcons.add(widget.trailingIcon!);
    }
    if (widget.isPassword && showEyeIcon) {
      trailingIcons.add(
        GestureDetector(
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          child:
              showPassword
                  ? SvgPicture.asset(AssetConstants.eyeSlashIcon)
                  : SvgPicture.asset(AssetConstants.eyeIcon),
        ),
      );
    }
    if (showClearIcon) {
      trailingIcons.add(
        GestureDetector(
          onTap: () {
            widget.controller?.clear();
            setState(() {
              showClearIcon = false;
            });
          },
          child: SvgPicture.asset(AssetConstants.clearIcon),
        ),
      );
    }

    return TextField(
      onTap: widget.onTap,
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      enabled: widget.isEnabled,
      obscureText: (widget.isPassword && !showPassword),
      readOnly: widget.isReadOnly,
      autofocus: widget.isAutoFocus,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      enableSuggestions: true,
      cursorHeight: 15,
      cursorColor: colors(context).primary,
      style: textTheme(
        context,
      ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: textTheme(context).titleSmall!.copyWith(
          color: colors(context).labelSecondary,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: colors(context).backgroundSecondary,
        focusColor: colors(context).backgroundTertiary,
        hoverColor: colors(context).backgroundTertiary,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        counterText: "",
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon:
            widget.leadingIcon != null
                ? Padding(
                  padding: const EdgeInsets.only(left: 18, right: 6),
                  child: widget.leadingIcon!,
                )
                : null,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: trailingIcons,
          ),
        ),
      ),
    );
  }
}
