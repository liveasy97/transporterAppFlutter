import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

class BookNowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_8,
      width:(space_16*2)+3,
      decoration: BoxDecoration(
          color: darkBlueColor, borderRadius: BorderRadius.circular(space_6)),
      child: Center(
        child: Text(
          "Book Now",
          style: TextStyle(
              fontSize: size_8, fontWeight: mediumBoldWeight, color: white),
        ),
      ),
    );
  }
}
