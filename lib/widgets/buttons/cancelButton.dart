import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
class CancelButton extends StatelessWidget {

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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: whiteButtonOutlineColor)),
        child: Center(
          child: Text(
            "Cancel",
            style: TextStyle(
                color: Colors.black,
                fontWeight: normalWeight,
                fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}
