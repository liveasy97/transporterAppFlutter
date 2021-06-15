import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

class BuyGpsWidget extends StatelessWidget {
  final double height;
  final double width;

  BuyGpsWidget({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.fromLTRB(space_2, space_2, 0,0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/buyGpsBackgroundImage.png"),
        ),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                "Buy GPS",
                style: TextStyle(
                    fontSize: size_10,
                    fontWeight: mediumBoldWeight,
                    color: white),
              ),
              Text(
                "Liveasy GPS system\nallows you to track\nyour vehicles from",
                style: TextStyle(fontSize: size_5, color: white),
              ),
            ],
          ),
          Container(
            height: space_11,
            width: space_9,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/buyGpsIcon.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
