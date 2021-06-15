import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/raidus.dart';
import 'package:liveasy/constants/spaces.dart';

// ignore: must_be_immutable
class ViewBidsButton extends StatefulWidget {
  @override
  _ViewBidsButtonState createState() => _ViewBidsButtonState();
}

class _ViewBidsButtonState extends State<ViewBidsButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: space_3),
        height: space_6 + 1,
        width: space_16,
        decoration: BoxDecoration(
            color: bidBackground,
            borderRadius: BorderRadius.circular(radius_4)),
        child: Center(
          child: Text(
            "View Biddings",
            style: TextStyle(
                color: white, fontWeight: normalWeight, fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}
