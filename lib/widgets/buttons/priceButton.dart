import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';

class PriceButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          color: priceBackground, borderRadius: BorderRadius.circular(5)),
      height: 35,
      width: 110,
      child: Center(
        child: Text(
          "\u20B96000/tonne",
          style: TextStyle(
              color: priceTextColor,
              fontWeight: mediumBoldWeight,
              fontSize: size_7),
        ),
      ),
    );
  }
}
