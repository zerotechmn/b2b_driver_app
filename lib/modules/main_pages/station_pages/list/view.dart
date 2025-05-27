import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/widgets/buttons/small_button.dart';
import 'package:b2b_driver_app/widgets/inputs/input.dart';
import 'package:b2b_driver_app/widgets/items/branch_item.dart';
import 'package:b2b_driver_app/widgets/items/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StationListView extends StatelessWidget {
  const StationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 41 + 16 * 2,
        ),
        child: Column(
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
                      leadingIcon: SvgPicture.asset(AssetConstants.searchIcon),
                    ),
                  ),
                  SmallButton(
                    icon: SvgPicture.asset(AssetConstants.filterIcon),
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
                separatorBuilder: (context, index) => SizedBox(width: 8),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView.separated(
                    padding: EdgeInsets.only(bottom: 16),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return BranchItem();
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
