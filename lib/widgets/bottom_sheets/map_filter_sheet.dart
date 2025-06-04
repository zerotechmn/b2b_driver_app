import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/drag_handler.dart';
import 'package:b2b_driver_app/widgets/buttons/small_button.dart';
import 'package:b2b_driver_app/widgets/inputs/input.dart';
import 'package:b2b_driver_app/widgets/items/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapFilterSheet extends StatelessWidget {
  const MapFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        expand: false,
        snap: true,
        snapSizes: [0.2, 0.4, 0.8],
        builder:
            (context, scrollController) => CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      DragHandler(),
                      Column(
                        spacing: 16,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              spacing: 16,
                              children: [
                                Expanded(
                                  child: Input(
                                    hint: "Салбар хайх",
                                    leadingIcon: SvgPicture.asset(
                                      AssetConstants.searchIcon,
                                    ),
                                  ),
                                ),
                                SmallButton(
                                  icon: SvgPicture.asset(
                                    AssetConstants.filterIcon,
                                  ),
                                  width: 50,
                                  height: 50,
                                  borderRadius: 16,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ListView.separated(
                              itemCount: 10,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return FilterItem();
                              },
                              separatorBuilder:
                                  (context, index) => SizedBox(width: 8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
