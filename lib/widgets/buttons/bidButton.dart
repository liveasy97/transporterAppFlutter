import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/raidus.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/alertDialog/bidButtonAlertDialog.dart';

// ignore: must_be_immutable
class BidButton extends StatefulWidget {
   String? loadId;

  BidButton(this.loadId);

  @override
  _BidButtonState createState() => _BidButtonState();
}

class _BidButtonState extends State<BidButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showInformationDialog(context,widget.loadId);
      },
      child: Container(
        margin: EdgeInsets.only(right: space_3),
        height: space_6 + 1,
        width: space_16,
        decoration: BoxDecoration(
            color: bidBackground,
            borderRadius: BorderRadius.circular(radius_4)),
        child: Center(
          child: Text(
            "Bid",
            style: TextStyle(
                color: white, fontWeight: normalWeight, fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}
