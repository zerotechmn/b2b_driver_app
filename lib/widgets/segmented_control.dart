import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomSegmentedControl extends StatefulWidget {
  final List<String> segments;
  final void Function(int index) onChange;
  final int? currentIndex;

  const CustomSegmentedControl({
    super.key,
    required this.segments,
    required this.onChange,
    this.currentIndex,
  }) : assert(segments.length >= 2 && segments.length <= 5);

  @override
  State<CustomSegmentedControl> createState() => _CustomSegmentedControlState();
}

class _CustomSegmentedControlState extends State<CustomSegmentedControl> {
  int selectedIndex = 0;

  @override
  void initState() {
    if (widget.currentIndex != null) {
      selectedIndex = widget.currentIndex!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double segmentWidth = (constraints.maxWidth) / widget.segments.length;

        return Container(
          height: 41,
          decoration: BoxDecoration(
            color: colors(context).backgroundSecondary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                left: selectedIndex * segmentWidth,
                width: segmentWidth,
                child: Container(
                  height: 41,
                  decoration: BoxDecoration(
                    color: colors(context).primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  widget.segments.length,
                  (index) => _buildSegment(widget.segments[index], index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSegment(String text, int index) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          widget.onChange(index);
        },
        child: Container(
          height: 41,
          alignment: Alignment.center,
          child: Text(
            text,
            style: textTheme(context).titleSmall!.copyWith(
              fontWeight: FontWeight.w500,
              color:
                  selectedIndex == index
                      ? colors(context).backgroundPrimary
                      : colors(context).labelPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
