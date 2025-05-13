import 'package:b2b_driver_app/theme/palette.dart';
import 'package:flutter/material.dart';

class TopIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox();
  }
}

class _TopIndicatorBox extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint paint =
        Paint()
          ..color = Palette.primary
          ..strokeWidth = 2
          ..isAntiAlias = true;

    canvas.drawLine(
      Offset(offset.dx, offset.dy + 1),
      Offset(cfg.size!.width + offset.dx, 1),
      paint,
    );
  }
}
