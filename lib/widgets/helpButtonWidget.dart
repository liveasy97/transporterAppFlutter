import 'package:flutter/material.dart';
import 'package:liveasy/constants/borderWidth.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';

class HelpButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: space_6,
        width: space_16,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
        border: Border.all(width: borderWidth_10, color: darkBlueColor)),
        padding: EdgeInsets.only(left: space_3),
        child: Center(
          child: Row(
            children: [
              Container(
                height: space_3,
                width: space_3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/helpIcon.png"))),
              ),
              SizedBox(
                width: space_1,
              ),
              Text(
                "Help",
                style: TextStyle(fontSize: size_7, color: darkBlueColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
