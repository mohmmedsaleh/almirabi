import 'package:almirabi/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStyle {
  static TextStyle menuStyle = TextStyle(
      color: AppColor.black, fontSize: 25, fontWeight: FontWeight.bold);
  static TextStyle cardTitle = TextStyle(
      color: AppColor.grey, fontSize: 25, fontWeight: FontWeight.bold);
  static TextStyle titleStyle = TextStyle(
      color: AppColor.black, fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle titleCount = TextStyle(
      color: AppColor.red, fontSize: 25, fontWeight: FontWeight.normal);
  static TextStyle toolTipStyle = TextStyle(
      color: AppColor.white, fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle cardsubtitle = TextStyle(
      color: AppColor.grey,
      fontSize: Get.width * 0.01,
      fontWeight: FontWeight.bold);
  static TextStyle cardsubtitleWithpurple = TextStyle(
      color: AppColor.purple.withOpacity(0.5),
      fontSize: Get.width * 0.01,
      fontWeight: FontWeight.bold);
  static TextStyle priceStyle = TextStyle(
      color: AppColor.green, fontSize: 23, fontWeight: FontWeight.normal);
  //
  static TextStyle header3 = TextStyle(
      color: AppColor.black, fontSize: 32, fontWeight: FontWeight.bold);
  static TextStyle header1 = TextStyle(
      color: AppColor.black,
      fontSize: Get.width * 0.02,
      fontWeight: FontWeight.bold);
  static TextStyle header2 = TextStyle(
      color: AppColor.black, fontSize: 36, fontWeight: FontWeight.normal);
  static TextStyle header4 = TextStyle(
      color: AppColor.black, fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle textStyle(
      {Color? color = const Color(0xFF000000),
      double? fontSize,
      FontWeight? fontWeight = FontWeight.bold}) {
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  static TextStyle snackbarTextStyle(context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColor.white);
}
