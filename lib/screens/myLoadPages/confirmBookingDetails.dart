import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/models/biddingModel.dart';
import 'package:liveasy/models/loadDetailsScreenModel.dart';
import 'package:liveasy/screens/myLoadPages/addNewDriver.dart';
import 'package:liveasy/widgets/HeadingTextWidgetBlue.dart';
import 'package:liveasy/widgets/buttons/confirmButtonSendRequest.dart';
//import 'package:fluttertoast/fluttertoast.dart';

import 'selectTruckScreen.dart';

class ConfirmBookingDetails extends StatefulWidget {
  // List? truckModelList;
  // List? driverModelList;
  // LoadDetailsScreenModel? loadDetailsScreenModel;
  // BiddingModel? biddingModel;

  // bool? directBooking;
  // String? postLoadId;
  String? selectedTruck;
  int? selectedDeviceId;
  String? driverName, mobileNo;
  LoadDetailsScreenModel? loadDetailsScreenModel;
  BiddingModel? biddingModel;
  bool? directBooking;
  String? postLoadId;

  ConfirmBookingDetails(
      {this.selectedTruck,
      this.selectedDeviceId,
      this.driverName,
      this.mobileNo,
      this.postLoadId,
      this.loadDetailsScreenModel,
      this.biddingModel,
      required this.directBooking});

  @override
  _ConfirmBookingDetailsState createState() => _ConfirmBookingDetailsState();
}

class _ConfirmBookingDetailsState extends State<ConfirmBookingDetails> {
  String? transporterId;
  String? mobileno;
  TransporterIdController transporterIdController = TransporterIdController();
  GetStorage tidstorage = GetStorage('TransporterIDStorage');

  @override
  Widget build(BuildContext context) {
    SnackBar snackBar = SnackBar(content: Text('Hello World'));
    return Scaffold(
      appBar: AppBar(
        title: HeadingTextWidgetBlue('confirmBookingDetails'.tr),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: statusBarColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: space_2),
            child: Column(
              children: [
                SizedBox(
                  height: space_4,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: space_3, horizontal: space_3),
                  child: Container(
                    height: 130,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 0.8,
                        //  color: widgetBackGroundColor
                        color: black,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "  Truck",
                                style: TextStyle(
                                  fontSize: size_10,
                                  color: darkBlueColor,
                                  fontWeight: mediumBoldWeight,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                      left: space_2 - 2,
                                      right: space_1 - 2,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: white,
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((context) {
                                              return SelectTruckScreen(
                                                  driverName: widget.driverName,
                                                  driverPhoneNo:
                                                      widget.mobileNo,
                                                  directBooking: true);
                                            })));
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: black,
                                          )),
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 25, top: 15),
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: widgetBackGroundColor,
                                borderRadius: BorderRadius.circular(13)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: widget.selectedTruck.toString() == "null"
                                  ? Text(
                                      " ",
                                      style: TextStyle(
                                          color: black, fontSize: size_10),
                                    )
                                  : Text(
                                      widget.selectedTruck.toString(),
                                      style: TextStyle(
                                          color: black, fontSize: size_10),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: space_3, horizontal: space_3),
                  child: Container(
                    height: 130,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 0.8,
                        //  color: widgetBackGroundColor
                        color: black,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "  Driver",
                                style: TextStyle(
                                  fontSize: size_10,
                                  color: darkBlueColor,
                                  fontWeight: mediumBoldWeight,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                      left: space_2 - 2,
                                      right: space_1 - 2,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: white,
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((context) {
                                              return AddNewDriver(
                                                selectedDeviceId:
                                                    widget.selectedDeviceId,
                                                selectedTruck:
                                                    widget.selectedTruck,
                                                loadDetailsScreenModel: widget
                                                    .loadDetailsScreenModel,
                                              );
                                            })));
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: black,
                                          )),
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 25, top: 15),
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: widgetBackGroundColor,
                                borderRadius: BorderRadius.circular(13)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: widget.driverName.toString() == "null"
                                  ? Text(
                                      "",
                                      style: TextStyle(
                                          color: black, fontSize: size_10),
                                    )
                                  : Text(
                                      "${widget.driverName}-${widget.mobileNo}",
                                      style: TextStyle(
                                          color: black, fontSize: size_10),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: ConfirmButtonSendRequest(
                        selectedDriverName: widget.driverName,
                        selectedDriverPhoneno: widget.mobileNo,
                        selectedDeviceId: widget.selectedDeviceId,
                        loadDetailsScreenModel: widget.loadDetailsScreenModel,
                        truckId: widget.selectedTruck,
                        directBooking: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
