import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/raidus.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/buttons/verifyNowButton.dart';

// ignore: non_constant_identifier_names
Future<void> VerifyAccountNotifyAlertDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog( //TODO: width have to be modified of the dialog box
            title: Column(
              children: [
                Image(
                    height: space_16,
                    width: (space_9 * 2) + 3,
                    image: AssetImage("assets/icons/errorIcon.png")),
                SizedBox(
                  height: space_2,
                ),
                Text(
                  "Your Account is not Verified",
                  style: TextStyle(
                      fontWeight: normalWeight,
                      fontSize: size_9,
                      color: liveasyOrange),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  "Upload details and get it verified",
                  style: TextStyle(
                      fontWeight: normalWeight, fontSize: size_9, color: black),
                ),
                Text(
                  "to book loads",
                  style: TextStyle(
                      fontWeight: normalWeight, fontSize: size_9, color: black),
                ),
                SizedBox(
                  height: space_8,
                )
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerifyNowButton(),
                ],
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
            ),
          );
        });
      });
}
