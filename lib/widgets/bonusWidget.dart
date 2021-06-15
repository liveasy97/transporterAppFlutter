import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

class BonusWidget extends StatelessWidget {
  final double height;
  final double width;

  BonusWidget({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.fromLTRB(space_2, space_2, 0, 0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bonusBackgroundImage.png"),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bonus",
                style: TextStyle(
                    fontSize: size_10,
                    fontWeight: mediumBoldWeight,
                    color: white),
              ),
              SizedBox(
                height: space_2,
              ),
              Text(
                "Keep booking\nusing Liveasy to\nearn more",
                style: TextStyle(fontSize: size_6, color: white),
              ),
            ],
          ),
          Container(
            height: space_13,
            width: space_13,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/bonusIcon.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
