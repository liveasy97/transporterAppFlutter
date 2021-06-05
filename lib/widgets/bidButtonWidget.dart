import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/bidButtonAlertDialog.dart';
import 'package:liveasy/widgets/bidButtonSendRequest.dart';
import 'package:liveasy/widgets/cancelButton.dart';

class BidButtonWidget extends StatefulWidget {

  @override
  _BidButtonWidgetState createState() => _BidButtonWidgetState();
}

class _BidButtonWidgetState extends State<BidButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showInformationDialog(context);
      },
      child: Container(
        margin: EdgeInsets.only(right: space_3),
        height: space_6+1,
        width: space_16,
        decoration: BoxDecoration(
            color: bidBackground, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            "Bid",
            style: TextStyle(
                color: Colors.white,
                fontWeight: normalWeight,
                fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}

