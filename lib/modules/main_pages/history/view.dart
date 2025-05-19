import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/appbars/home_appbar.dart';
import 'package:b2b_driver_app/widgets/items/history_item.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomeAppBar(context, "Dulguun"),
      backgroundColor: colors(context).backgroundSecondary,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          children: [
            Row(
              spacing: 8,
              children: [
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: colors(context).backgroundPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: colors(context).backgroundPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: 87,
                    decoration: BoxDecoration(
                      color: colors(context).backgroundPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: 87,
                    decoration: BoxDecoration(
                      color: colors(context).backgroundPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors(context).backgroundPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                spacing: 16,
                children: [HistoryItem(), HistoryItem()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
