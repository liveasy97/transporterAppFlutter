//container below card
import 'package:flutter/material.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/widgets/buttons/callButton.dart';

class ContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      padding: EdgeInsets.symmetric(horizontal: 15),
      color: contactPlaneBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.apartment_outlined, //TODO: to be modified
                color: Color.fromRGBO(42, 46, 59, 1),
              ),
              Text(
                "Asian Paints",
                style:
                    TextStyle(fontSize: size_7, fontWeight: mediumBoldWeight),
              )
            ],
          ),
          CallButton(),
        ],
      ),
    );
  }
}
