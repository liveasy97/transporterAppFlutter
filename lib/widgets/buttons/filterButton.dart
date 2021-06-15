import 'package:flutter/material.dart';
import 'package:liveasy/constants/borderWidth.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

class FilterButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: space_6,
        width: space_16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: borderWidth_10, color: borderBlueColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Filter",
              style: TextStyle(
                  fontSize: size_7,
                  color: borderBlueColor,
                  fontWeight: normalWeight),
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              height: space_3 + 0.23,
              width: space_3 + 0.55,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/icons/filterIcon.png"))), //TODO: to be modified
            ),
          ],
        ),
      ),
    );
  }
}
