import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/raidus.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/postBidApi.dart';

// ignore: must_be_immutable
class BidButtonSendRequest extends StatelessWidget {
  String loadId, rate, unit;

  BidButtonSendRequest(this.loadId, this.rate, this.unit);

  TransporterIdController tIdController = Get.find<TransporterIdController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        postBidAPi(loadId, rate, tIdController.transporterId.value, unit);
        Get.back();
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
                color: Colors.white,
                fontWeight: normalWeight,
                fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}
