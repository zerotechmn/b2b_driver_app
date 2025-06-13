import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.size,
    required this.icon,
    this.onPressed,
  });

  final double size;
  final Widget icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(size / 2)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(size / 2),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(size / 2),
          child: icon,
        ),
      ),
    );
  }
}
