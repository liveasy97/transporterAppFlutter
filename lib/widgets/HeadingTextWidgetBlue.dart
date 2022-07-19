import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';

class HeadingTextWidgetBlue extends StatelessWidget {
  final String headingText;

  HeadingTextWidgetBlue(this.headingText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        headingText,
        style: TextStyle(
            fontSize: size_10,
            fontWeight: FontWeight.bold,
            color: darkBlueColor,
            letterSpacing: -0.408),
      ),
    );
  }
}
