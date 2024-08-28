import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class TextStyles {
  static TextStyle font24Blue700Weight = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: ColorsManager.mainGreen,
  );

  static TextStyle font14Blue400Weight = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.mainGreen,
  );

  static TextStyle font16White600Weight = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle font17Grey600Weight = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: ColorsManager.gray,
  );
  static TextStyle font13Grey400Weight = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.gray,
  );
  static TextStyle font14Grey400Weight = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.gray,
  );
  static TextStyle font14Hint500Weight = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: ColorsManager.gray76,
  );
  static TextStyle font14DarkBlue500Weight = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: ColorsManager.darkBlue,
  );
  static TextStyle font15DarkBlue500Weight = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: ColorsManager.darkBlue,
  );
  static TextStyle font11DarkBlue500Weight = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: ColorsManager.darkBlue,
  );
  static TextStyle font11DarkBlue400Weight = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.darkBlue,
  );
  static TextStyle font11Blue600Weight = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: ColorsManager.mainGreen,
  );
  static TextStyle font11MediumLightShadeOfGray400Weight = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.mediumLightShadeOfGray,
  );
}

class TextDecorations {
  static InputDecoration getLabellessTextFieldDecoration(
      {required String placeholder, required BuildContext context}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      hintText: placeholder,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: ColorsManager.textFieldFillColor,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black38, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
