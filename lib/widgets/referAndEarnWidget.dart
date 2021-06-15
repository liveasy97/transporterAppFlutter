import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

class ReferAndEarnWidget extends StatelessWidget {
  final double height;
  final double width;

  ReferAndEarnWidget({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.fromLTRB(space_2, space_2, 0, 0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/referAndEarnBackgroundImage.png"),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Refer And earn",
            style: TextStyle(
                fontSize: size_10, fontWeight: mediumBoldWeight, color: white),
          ),
          Row(
            children: [
              Text(
                "Refer Liveasy to earn\npremium account",
                style: TextStyle(
                    fontSize: size_6, color: white, fontWeight: regularWeight),
              ),
              Container(
                height: space_13,
                width: space_9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icons/referAndEarnIcon.png"),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}