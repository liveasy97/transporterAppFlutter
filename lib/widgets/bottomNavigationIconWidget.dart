import 'package:flutter/material.dart';
import 'package:liveasy/constants/spaces.dart';

class BottomNavigationIconWidget extends StatelessWidget {
  final iconPath;
  BottomNavigationIconWidget({required this.iconPath});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: space_6,
      height: space_4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              "assets/icons/navigationIcons/$iconPath"),
        ),
      ),);
  }
}
