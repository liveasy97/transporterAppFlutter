import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/raidus.dart';
import 'package:liveasy/constants/spaces.dart';
class VerifyNowButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.only(right: space_3),
        height: space_8,
        width: (space_16*2)+3,
        decoration: BoxDecoration(
            color: bidBackground, borderRadius: BorderRadius.circular(radius_6)),
        child: Center(
          child: Text(
            "Verify Now",
            style: TextStyle(
                color: white,
                fontWeight: mediumBoldWeight,
                fontSize: size_8),
          ),
        ),
      ),
    );
  }
}