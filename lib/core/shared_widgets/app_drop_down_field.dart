// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';

class ContainerDropDownField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final String hintText;
  FocusNode? focusNode;
  final Function()? onTap;
  String? Function(dynamic)? validator;
  final void Function(dynamic)? onChanged;
  Function(String)? onFieldSubmitted;
  double? width;
  double? height;
  double? borderRadius;
  Color? color, hintcolor, iconcolor;
  double? fontSize;
  double? horizontal;
  double? vertical;
  TextAlign? textAlign;
  String? value;
  bool? isPIN;
  List<DropdownMenuItem<String>>? items;

  ContainerDropDownField(
      {super.key,
      this.prefixIcon,
      this.suffixIcon,
      required this.labelText,
      required this.hintText,
      this.focusNode,
      this.onTap,
      this.isPIN = false,
      this.validator,
      required this.onChanged,
      this.onFieldSubmitted,
      this.iconcolor,
      this.hintcolor,
      this.width,
      this.height,
      this.borderRadius = 15,
      this.fontSize,
      this.textAlign = TextAlign.start,
      this.color,
      this.horizontal = 10,
      this.vertical = 10,
      required this.items,
      this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width / 2.7,
      height: height ?? MediaQuery.sizeOf(context).height * 0.07,
      child: DropdownButtonFormField<String>(
        onTap: onTap,

        // alignment: AlignmentDirectional.centerStart,
        isExpanded: true,
        focusColor: AppColor.white.withOpacity(0),
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: value,

        // hint: Center(
        //   child: Text(
        //     hintText,
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //         color: hintcolor ?? AppColor.greyWithOpcity,
        //         fontSize: fontSize,
        //         fontWeight: FontWeight.bold),
        //   ),
        // ),

        style: TextStyle(
            color: color ?? AppColor.black,
            fontSize: fontSize ?? Get.width * 0.03,
            overflow: TextOverflow.ellipsis,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            label: Text(
              labelText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: hintcolor ?? AppColor.greyWithOpcity,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold),
            ),
            focusedBorder: isPIN!
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: AppColor.brawn,
                    )),
            border: isPIN!
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: AppColor.brawn,
                    )),
            prefixIcon: prefixIcon,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            // hintStyle: TextStyle(
            //     color: hintcolor ?? AppColor.greyWithOpcity,
            //     fontSize: fontSize,
            //     fontWeight: FontWeight.bold),
            errorStyle: const TextStyle(
              fontSize: 0,
            )),
        validator: validator,
        dropdownColor: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
