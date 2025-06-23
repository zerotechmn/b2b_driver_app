import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/inputs/input.dart';
import 'package:b2b_driver_app/widgets/items/select_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectOption {
  final String value;
  final String label;

  SelectOption({required this.value, required this.label});
}

class Select extends StatelessWidget {
  const Select({
    super.key,
    required this.hint,
    required this.controller,
    required this.options,
    this.onChanged,
    this.selectedValue,
  });

  final String hint;
  final TextEditingController controller;
  final List<SelectOption> options;
  final void Function(String value, String label)? onChanged;
  final String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Input(
      hint: hint,
      onTap: () => _showOptionsBottomSheet(context),
      controller: controller,
      trailingIcon:
          controller.text.isNotEmpty
              ? null
              : SvgPicture.asset(AssetConstants.arrowDownCircleIcon),
      isReadOnly: true,
      showClearIcon: true,
    );
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (context) => Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            decoration: BoxDecoration(
              color: colors(context).backgroundPrimary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with drag handle
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: 32,
                        height: 4,
                        decoration: BoxDecoration(
                          color: colors(context).backgroundSecondary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        hint,
                        style: textTheme(
                          context,
                        ).titleMedium!.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),

                // Divider
                Divider(color: colors(context).backgroundSecondary, height: 1),

                // Options list
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(16),
                    itemCount: options.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final option = options[index];
                      return SelectItem(
                        value: option.value,
                        label: option.label,
                        isSelected: selectedValue == option.value,
                        onTap: (value) {
                          // Update the controller text
                          controller.text = option.label;

                          // Call the callback if provided
                          onChanged?.call(option.value, option.label);

                          // Close the bottom sheet
                          Get.back();
                        },
                      );
                    },
                  ),
                ),

                // Bottom safe area
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
    );
  }
}
