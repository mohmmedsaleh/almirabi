// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';

class ButtonElevated extends StatelessWidget {
  Function()? onPressed;
  String text;
  double minimumSize;
  Color? backgroundColor;
  Color? textColor;
  Color? borderColor;
  double? borderRadius;
  double? width;
  double? height;
  TextStyle? textStyle;

  ButtonElevated(
      {super.key,
      this.onPressed,
      required this.text,
      this.minimumSize = 40,
      this.backgroundColor,
      this.textColor,
      this.borderColor,
      this.borderRadius = 15.0,
      this.width,
      this.height,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.sizeOf(context).width / 2.7,
        height: height ?? MediaQuery.sizeOf(context).height * 0.05,
        decoration: BoxDecoration(
          color: borderColor == null ? (backgroundColor ?? AppColor.shadepurple) : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius!),
          border: borderColor != null ? Border.all(width: 2, color: borderColor!) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? TextStyle(
                color: borderColor != null ? AppColor.shadepurple : Colors.white, fontSize: Get.height * 0.02, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
