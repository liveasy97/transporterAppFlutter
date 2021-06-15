import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/raidus.dart';
import 'package:liveasy/constants/spaces.dart';
class ConfirmButtonSendRequest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.only(right: space_3),
        height: space_6+1,
        width: space_16,
        decoration: BoxDecoration(
            color: bidBackground, borderRadius: BorderRadius.circular(radius_4)),
        child: Center(
          child: Text(
            "Confirm",
            style: TextStyle(
                color: white,
                fontWeight: normalWeight,
                fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}
