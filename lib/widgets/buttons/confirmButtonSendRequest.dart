import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/navigationIndexController.dart';
import 'package:liveasy/functions/postBookingApi.dart';
import 'package:liveasy/functions/postBookingApiNew.dart';
import 'package:liveasy/functions/truckApis/truckApiCalls.dart';
import 'package:liveasy/models/biddingModel.dart';
import 'package:liveasy/models/loadDetailsScreenModel.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/navigationScreen.dart';
import 'package:liveasy/widgets/alertDialog/CompletedDialog.dart';
import 'package:liveasy/widgets/alertDialog/conflictDialog.dart';
import 'package:liveasy/widgets/alertDialog/loadingAlertDialog.dart';
import 'package:liveasy/widgets/alertDialog/orderFailedAlertDialog.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ConfirmButtonSendRequest extends StatefulWidget {
  bool? directBooking;
  String? truckId;
  int? selectedDeviceId;
  BiddingModel? biddingModel;
  String? selectedDriverName;
  String? selectedDriverPhoneno;
  String? postLoadId;
  LoadDetailsScreenModel? loadDetailsScreenModel;

  ConfirmButtonSendRequest(
      {this.directBooking,
      this.truckId,
      this.selectedDeviceId,
      this.biddingModel,
      this.postLoadId,
      this.loadDetailsScreenModel,
      this.selectedDriverName,
      this.selectedDriverPhoneno});

  @override
  _ConfirmButtonSendRequestState createState() =>
      _ConfirmButtonSendRequestState();
}

TruckApiCalls truckApiCalls = TruckApiCalls();

class _ConfirmButtonSendRequestState extends State<ConfirmButtonSendRequest> {
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    NavigationIndexController navigationIndexController =
        Get.find<NavigationIndexController>();
    getBookingData() async {
      String? bookResponse = "";
      if (bookResponse == "") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoadingAlertDialog();
          },
        );
      }
      if (widget.directBooking == true) {
        //truckApiCalls.updateDriverIdForTruck(
          //  driverID: widget.selectedDriver, truckID: widget.truckId);
        bookResponse = await postBookingApiNew(
          widget.loadDetailsScreenModel,
          widget.truckId,
          widget.selectedDeviceId,
          widget.selectedDriverName,
          widget.selectedDriverPhoneno,
        );
        print("directBooking");
      } else {
        //truckApiCalls.updateDriverIdForTruck(
          //  driverID: widget.selectedDriver, truckID: widget.truckId);
        bookResponse = await postBookingApi(
          widget.biddingModel!.loadId,
          widget.biddingModel!.currentBid,
          widget.biddingModel!.unitValue,
          widget.truckId,
          widget.postLoadId,
          widget.loadDetailsScreenModel!.rate,
        );
      }

      if (bookResponse == "successful") {
        print(bookResponse);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return completedDialog(
              upperDialogText: "Your booking is confirmed",
              lowerDialogText: "",
            );
          },
        );
        Timer(
            Duration(seconds: 3),
            () => {
                  providerData.updateUpperNavigatorIndex(1),
                  Get.offAll(NavigationScreen()),
                  navigationIndexController.updateIndex(3),
                });
      } else if (bookResponse == "conflict") {
        // change this according to the booking response
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConflictDialog(dialog: 'You have already booked this load');
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return OrderFailedAlertDialog();
          },
        );
        // Get.snackbar("${postLoadErrorController.error.value}", "failed");
        // postLoadErrorController.resetPostLoadError();
        // print(postLoadErrorController.error.value.toString());
        // Timer(
        //     Duration(seconds: 1),
        //     () => {
        //           showDialog(
        //             context: context,
        //             builder: (BuildContext context) {
        //               return OrderFailedAlertDialog(
        //                   postLoadErrorController.error.value.toString());
        //             },
        //           )
        //         });
      }
    }

    if (widget.biddingModel != null) {
      widget.biddingModel!.unitValue =
          widget.biddingModel!.unitValue == 'tonne' ? 'PER_TON' : 'PER_TRUCK';
    }

    return GestureDetector(
      onTap: widget.truckId != null
          ? () {
              getBookingData();
            }
          : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 50, left: 10, right: 10),
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: darkBlueColor,
            ),
            height: 75,
            width: 290,
            child: Center(
              child: Text(
                "Continue Booking",
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: size_12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
