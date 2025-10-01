
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';

import '../bloc/device_cubit/device_cubit.dart';
import '../theme/text/app_text_style.dart';

class AdaptivePicker {
  static datePicker(
      {required BuildContext context,
      required Function(DateTime? date) onConfirm,
      required String title,
      DateTime? initial,
      DateTime? minDate,
      required DateTime maxDate}) async {
    

    // if (Platform.isIOS) {
    //   _iosDatePicker(context, onConfirm, title, initial: initial, minDate: minDate);
    // } else {
      _androidDatePicker(context, onConfirm, initial: initial, minDate: minDate, maxDate: maxDate);
    // }
  }

  static _androidDatePicker(
      BuildContext context, Function(DateTime? date) onConfirm,
      {DateTime? initial, DateTime? minDate, DateTime? maxDate}) {
    showRoundedDatePicker(
        context: context,
        initialDate: initial ?? DateTime.now(),
        firstDate: minDate ?? DateTime.now().add(const Duration(days: -1)),
        lastDate: maxDate ?? DateTime(2050),
        borderRadius: 16,
        height: 320,
        theme: ThemeData.light().copyWith(
          primaryColor: context.colors.primary,
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        )).then(onConfirm);
  }

  static _iosDatePicker(
      BuildContext context, Function(DateTime? date) onConfirm, String title,
      {DateTime? initial, DateTime? minDate}) {
    _bottomSheet(
      context: context,
      child: cupertinoDatePicker(context, onConfirm, title,
          initial: initial, minDate: minDate),
    );
  }

  static Widget cupertinoDatePicker(
      BuildContext context, Function(DateTime? date) onConfirm, String title,
      {DateTime? initial, DateTime? minDate}) {
    DateTime date = DateTime.now();
    return SizedBox(
      height: 260,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:
                      AppTextStyle.s14_w500(color: context.colors.blackOpacity),
                ),
                ElevatedButton(
                  onPressed: () {
                    onConfirm(date);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: context.colors.white),
                  child: Text(
                    "Done",
                    style: AppTextStyle.s14_w400(color: context.colors.primary),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: CupertinoDatePicker(
              initialDateTime: initial ?? DateTime.now(),
              onDateTimeChanged: (date) {
                date = date;
              },
              minimumDate:
                  minDate ?? DateTime.now().add(const Duration(days: -1)),
              mode: CupertinoDatePickerMode.date,
            ),
          ),
        ],
      ),
    );
  }

  static timePicker(
      {required BuildContext context,
      required String title,
      required Function(DateTime? date) onConfirm}) async {
    _iosTimePicker(context, "", onConfirm);
  }

  static _androidTimePicker(
      BuildContext context, Function(DateTime date) onConfirm) {
    var now = DateTime.now();
    var local = context.read<DeviceCubit>().state.model.locale;
    showRoundedTimePicker(
      context: context,
      locale: local,
      theme: ThemeData(
        primaryColor: context.colors.primary,
        brightness: Brightness.dark,
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      initialTime: TimeOfDay.now(),
    ).then((time) => onConfirm(
        DateTime(now.year, now.month, now.day, time!.hour, time.minute)));
  }

  static _iosTimePicker(
      BuildContext context, String title, Function(DateTime? date) onConfirm) {
    _bottomSheet(
      context: context,
      child: cupertinoTimePicker(context, title, onConfirm),
    );
  }

  static Widget cupertinoTimePicker(
      BuildContext context, String title, Function(DateTime? date) onConfirm) {
    DateTime date = DateTime.now();
    return Container(
      height: 340.h,
      decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: BorderRadius.circular(15).r),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.s14_w500(
                        color: context.colors.blackOpacity),
                  ),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        // onConfirm(date);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: context.colors.white),
                      child: Text(
                        "Done",
                        style: AppTextStyle.s14_w400(
                            color: context.colors.primary),
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle:
                      TextStyle(color: context.colors.black),
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: onConfirm,
                use24hFormat: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future _bottomSheet(
      {required BuildContext context, required Widget child}) {
    return showModalBottomSheet(
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13), topRight: Radius.circular(13)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => SizedBox(
        height: 340,
        child: child,
      ),
    );
  }
}
