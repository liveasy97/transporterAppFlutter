import 'package:flutter/material.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';

class BodyTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  BodyTextWidget({required this.text, required this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontSize: size_8,
        fontWeight: regularWeight,
        color: color,
      ),
    );
  }
}
