import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';

class HeaderIcons extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final bool darkBackground;

  const HeaderIcons(
      {super.key,
      required this.icon,
      required this.onTap,
      this.darkBackground = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      // padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: !darkBackground ? AppColor.purple.withOpacity(0.4) : Colors.transparent,
              width: 1)),
      child: IconButton(
        icon: Icon(icon),
        color: !darkBackground ? AppColor.purple.withOpacity(0.7) : AppColor.white,
        iconSize: Get.height * 0.025,
        onPressed: onTap,
      ),
    );
  }
}
