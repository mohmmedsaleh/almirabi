import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String assetPath;
  final double size;

  const CustomIcon({
    Key? key,
    required this.assetPath,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
        //  fit: BoxFit.contain,
      ),
    );
  }
}
