import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

class AvailableLoadsTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
        height: space_5-3,
        child: Center(
        child: Text(
        "Available Loads",
        style: TextStyle(
        fontSize:  size_11,
              color: black,
              fontWeight: mediumBoldWeight),
        ),
      ),
    );
  }
}