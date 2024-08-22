import 'package:almirabi/core/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final double padding;
  final Color color;

  const CustomIcon(
      {super.key,
      required this.assetPath,
      required this.size,
      this.padding = 6,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Image.asset(assetPath, width: size, height: size, color: color
          //  fit: BoxFit.contain,
          ),
    );
  }
}
