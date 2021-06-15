import 'package:flutter/material.dart';

class UnloadingPointImageIcon extends StatelessWidget {
  final double height;
  final double width;
  UnloadingPointImageIcon({required this.width, required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              "assets/icons/redSemiFilledCircleIcon.png"),
        ),
      ),
    );
  }
}
