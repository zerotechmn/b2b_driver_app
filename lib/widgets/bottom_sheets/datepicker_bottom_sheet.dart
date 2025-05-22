import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/drag_handler.dart';
import 'package:b2b_driver_app/widgets/buttons/button.dart';
import 'package:b2b_driver_app/widgets/buttons/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DatepickerBottomSheet extends StatefulWidget {
  const DatepickerBottomSheet({super.key, this.defaultValue});

  final DateTime? defaultValue;

  @override
  State<DatepickerBottomSheet> createState() => _DatepickerBottomSheetState();
}

class _DatepickerBottomSheetState extends State<DatepickerBottomSheet> {
  DateTime focusedDay = DateTime.now();
  late PageController controller;

  @override
  void initState() {
    if (widget.defaultValue != null) {
      focusedDay = widget.defaultValue!;
    }
    super.initState();
  }

  changePage(int navigation) {
    if (navigation.isNegative) {
      controller.previousPage(
        duration: Duration(milliseconds: 350),
        curve: Curves.bounceOut,
      );
    } else {
      controller.nextPage(
        duration: Duration(milliseconds: 350),
        curve: Curves.bounceOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors(context).backgroundPrimary,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DragHandler(),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors(context).backgroundSecondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    spacing: 8,
                    children: [
                      SvgPicture.asset(
                        AssetConstants.calendarIcon,
                        width: 24,
                        height: 24,
                        fit: BoxFit.scaleDown,
                      ),
                      Expanded(
                        child: Text(
                          DateFormat.yMd('mn_MN').format(focusedDay),
                          style: textTheme(
                            context,
                          ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      CustomIconButton(
                        onPressed: () {
                          changePage(-1);
                        },
                        icon: RotatedBox(
                          quarterTurns: 2,
                          child: SvgPicture.asset(
                            AssetConstants.chevronRightIcon,
                            width: 24,
                            height: 24,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        size: 24,
                      ),
                      CustomIconButton(
                        onPressed: () {
                          changePage(1);
                        },
                        icon: SvgPicture.asset(
                          AssetConstants.chevronRightIcon,
                          width: 24,
                          height: 24,
                          fit: BoxFit.scaleDown,
                        ),
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              TableCalendar(
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.utc(DateTime.now().year + 10, 12, 31),
                focusedDay: focusedDay,
                onDaySelected: (sDay, fDay) {
                  setState(() {
                    focusedDay = fDay;
                  });
                },
                onPageChanged: (fDay) {
                  setState(() {
                    focusedDay = fDay;
                  });
                },
                onCalendarCreated: (pageController) {
                  controller = pageController;
                },
                availableGestures: AvailableGestures.horizontalSwipe,
                dayHitTestBehavior: HitTestBehavior.translucent,
                currentDay: DateTime.now(),
                startingDayOfWeek: StartingDayOfWeek.monday,
                locale: "mn_MN",
                headerVisible: false,
                rowHeight: 45 + 8,
                daysOfWeekHeight: 45,
                calendarStyle: CalendarStyle(cellMargin: EdgeInsets.all(4)),
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    final text = DateFormat.E('mn_MN').format(day);
                    return Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 2,
                          color: colors(context).backgroundSecondary!,
                        ),
                        color: colors(context).backgroundSecondary,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Center(
                        child: Text(
                          text,
                          style: textTheme(
                            context,
                          ).bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    return Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 2,
                          color: colors(context).backgroundSecondary!,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: textTheme(context).bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colors(context).labelSecondary,
                          ),
                        ),
                      ),
                    );
                  },
                  todayBuilder: (context, day, focusedDay) {
                    return Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 2,
                          color: colors(context).primary!,
                        ),
                        color:
                            focusedDay != day
                                ? colors(context).backgroundPrimary
                                : colors(context).primary,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: textTheme(context).bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color:
                                focusedDay != day
                                    ? colors(context).labelPrimary
                                    : colors(context).backgroundPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    return Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border:
                            focusedDay != day
                                ? Border.all(
                                  width: 2,
                                  color: colors(context).backgroundSecondary!,
                                )
                                : null,
                        color:
                            focusedDay != day
                                ? colors(context).backgroundPrimary
                                : colors(context).primary,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: textTheme(context).bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color:
                                focusedDay != day
                                    ? colors(context).labelPrimary
                                    : colors(context).backgroundPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 32),
              Button(
                text: "Сонголт хийх",
                onPressed: () {
                  Get.back(result: focusedDay);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
