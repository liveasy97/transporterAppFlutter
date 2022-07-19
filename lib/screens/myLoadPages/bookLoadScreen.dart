import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/mapUtils/getLoactionUsingImei.dart';
import 'package:liveasy/models/biddingModel.dart';
import 'package:liveasy/models/loadDetailsScreenModel.dart';
import 'package:liveasy/screens/myLoadPages/addNewDriver.dart';
import 'package:liveasy/screens/myLoadPages/selectTruckScreen.dart';
import 'package:liveasy/widgets/HeadingTextWidgetBlue.dart';
import 'package:liveasy/widgets/buttons/backButtonWidget.dart';
// import 'addDriverAlertDialog.dart';

// ignore: must_be_immutable
class BookLoadScreen extends StatefulWidget {
  List? truckModelList;
  List? driverModelList;
  LoadDetailsScreenModel? loadDetailsScreenModel;
  BiddingModel? biddingModel;
  bool? directBooking;
  String? postLoadId;

  BookLoadScreen(
      {this.truckModelList,
      this.postLoadId,
      this.driverModelList,
      this.loadDetailsScreenModel,
      this.biddingModel,
      required this.directBooking});

  @override
  _BookLoadScreenState createState() => _BookLoadScreenState();
}

class _BookLoadScreenState extends State<BookLoadScreen> {
  String? selectedTruck;
  String? selectedDriver;
  String? selectedDriverName;

  TransporterIdController transporterIdController = Get.find();

  late List? driverList = [];
  late List? truckList = [];

  MapUtil mapUtil = MapUtil();

  getTruckList() async {
    // FutureGroup futureGroup = FutureGroup();

    var a = mapUtil.getDevices(); ///////////////////////////
    // var b = mapUtil.getTraccarPositionforAll(); /////////////////////
    var devices = await a; /////////////////////
    // setState(() {
    //   truckList = devices;
    // });
    // truckList = devices;
    // var gpsDataAll = await b; ////////////////////
    truckList!.clear();
    // // devicelist.clear();
    for (var device in devices) {
      setState(() {
        truckList!.add(device.truckno);
        print(truckList);
        // devicelist.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  refresh() {
    setState(() {
      var page = ModalRoute.of(context)!.settings.name;
      Get.to(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButtonWidget(),
                    SizedBox(
                      width: space_3,
                    ),
                    HeadingTextWidgetBlue('enterBookingDetails'.tr),
                  ],
                ),
                SizedBox(
                  height: space_3,
                ),
                SizedBox(
                  height: space_2 + 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: space_4, right: space_4, bottom: space_2),
                      child: Text(
                        "1.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: size_12),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: space_2),
                      child: Text(
                        "Select Truck",
                        style: TextStyle(
                            fontSize: size_9,
                            fontWeight: mediumBoldWeight,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: ((context) {
                      return SelectTruckScreen(
                        loadDetailsScreenModel: widget.loadDetailsScreenModel,
                        directBooking: true,
                      );
                    })));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: space_10, right: space_5, bottom: space_2),
                    height: space_9 + 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius_1 + 2),
                        border: Border.all(color: darkGreyColor)),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: space_2 - 2,
                          right: space_2 - 2,
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: white,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: black,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: space_2 + 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: space_4, right: space_3, bottom: space_2),
                      child: Text(
                        "2.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: size_12),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: space_2),
                      child: Text(
                        "Select Driver",
                        style: TextStyle(
                            fontSize: size_9,
                            fontWeight: mediumBoldWeight,
                            color: black),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: ((context) {
                      return AddNewDriver(
                        loadDetailsScreenModel: widget.loadDetailsScreenModel,
                      );
                    })));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: space_10, right: space_5, bottom: space_2),
                    height: space_9 + 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius_1 + 2),
                        border: Border.all(color: darkGreyColor)),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: space_2 - 2,
                          right: space_2 - 2,
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: white,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: black,
                            )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 50, left: 10, right: 10),
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radius_4)),
                        color: grey,
                        child: Container(
                          color: grey,
                          height: 75,
                          width: 290,
                          child: Center(
                            child: Text(
                              "Proceed",
                              style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: size_12,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
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
