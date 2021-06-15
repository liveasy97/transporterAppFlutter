import 'package:flutter/material.dart';
class LoadingPointImageIcon extends StatelessWidget {
  final double height;
  final double width;
  LoadingPointImageIcon({required this.width, required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              "assets/icons/greenFilledCircleIcon.png"),
        ),
      ),
    );
  }
}
