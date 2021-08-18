import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/screens/buyGpsScreen.dart';

class BuyGpsLongWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => BuyGpsScreen()),
      child: Container(
        height: (space_20 + 2),
        width: double.maxFinite,
        padding: EdgeInsets.fromLTRB(space_4, space_3, space_6, 0),
        decoration: BoxDecoration(
          color: white,
          image: DecorationImage(
              image: AssetImage("assets/images/buyGpsBackgroundImage.png"),
              fit: BoxFit.fill),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Buy GPS",
                  style: TextStyle(
                      fontSize: size_10,
                      fontWeight: mediumBoldWeight,
                      color: white),
                ),
                Text(
                  "Liveasy GPS system allows you\nto track your vehicles from the\napp.",
                  style: TextStyle(fontSize: size_6, color: white),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: space_1),
                height: space_11,
                width: space_9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icons/buyGpsIcon.png"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
