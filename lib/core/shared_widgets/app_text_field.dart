// ignore_for_file: must_be_immutable

import 'package:almirabi/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ContainerTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final bool readOnly;
  FocusNode? focusNode;
  final Function()? onTap;
  String? Function(String?)? validator;
  final void Function(String)? onChanged;
  Function(String)? onFieldSubmitted;
  final TextEditingController controller;
  double? width;
  double? height;
  double? borderRadius;
  Color? color, hintcolor, iconcolor, borderColor;
  double? fontSize;
  double? horizontal;
  double? vertical;
  int? maxLength;
  TextAlign? textAlign;
  bool? isPIN;
  bool? isAddOrEdit;
  List<TextInputFormatter>? inputFormatters;

  ContainerTextField(
      {super.key,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType = TextInputType.text,
      required this.labelText,
      required this.hintText,
      this.obscureText = false,
      this.readOnly = false,
      this.isPIN = false,
      this.isAddOrEdit = false,
      this.focusNode,
      this.maxLength,
      this.onTap,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted,
      this.hintcolor,
      this.iconcolor,
      this.borderColor,
      required this.controller,
      this.width,
      this.height,
      this.borderRadius = 20,
      this.fontSize,
      this.textAlign = TextAlign.start,
      this.color,
      this.horizontal = 10,
      this.vertical = 10,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width / 2.7,
      height: height ?? MediaQuery.sizeOf(context).height * 0.07,
      child: TextFormField(
        // maxLength: maxLength ?? 10,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        readOnly: readOnly,
        textAlign: isPIN! ? TextAlign.center : TextAlign.start,
        obscureText: obscureText ? true : false,
        inputFormatters: inputFormatters,
        obscuringCharacter: isPIN! ? "*" : '•',
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
            color: color,
            fontSize: fontSize ?? Get.width * 0.01,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            labelText:
                isAddOrEdit != null && isAddOrEdit == true ? labelText : null,
            counterText: "",
            hintText:
                isAddOrEdit != null && isAddOrEdit == true ? null : hintText,
            prefixIcon: Icon(
              prefixIcon,
              color: iconcolor,
            ),
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
                borderSide: BorderSide(
                  color: borderColor != null ? borderColor! : AppColor.grey,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
                borderSide: BorderSide(
                  color: borderColor != null ? borderColor! : AppColor.grey,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
                borderSide: BorderSide(
                  color: AppColor.red,
                )),
            // border: isPIN! ? InputBorder.none : const OutlineInputBorder(),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            hintStyle: TextStyle(
                color: hintcolor ?? AppColor.greyWithOpcity,
                fontSize: fontSize,
                fontWeight: FontWeight.bold),
            errorStyle: const TextStyle(
              fontSize: 0,
            )),
        validator: validator,
      ),
    );
  }
}
