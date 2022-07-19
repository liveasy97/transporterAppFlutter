import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/mapUtils/getLoactionUsingImei.dart';
import 'package:liveasy/models/biddingModel.dart';
import 'package:liveasy/models/loadDetailsScreenModel.dart';
import 'package:liveasy/screens/myLoadPages/confirmBookingDetails.dart';
import 'package:liveasy/widgets/buttons/backButtonWidget.dart';
import 'package:liveasy/widgets/headingTextWidget.dart';

class SelectTruckScreen extends StatefulWidget {
  // List? truckModelList;
  // List? driverModelList;
  LoadDetailsScreenModel? loadDetailsScreenModel;
  BiddingModel? biddingModel;
  bool? directBooking;
  String? postLoadId;
  String? driverName, driverPhoneNo;
  SelectTruckScreen(
      {this.postLoadId,
      this.loadDetailsScreenModel,
      this.biddingModel,
      this.driverName,
      this.driverPhoneNo,
      required this.directBooking});

  @override
  State<SelectTruckScreen> createState() => _SelectTruckScreenState();
}

class _SelectTruckScreenState extends State<SelectTruckScreen> {
  late String selectedTruck;
  late int selectedDeviceId;
  int selectedIndex = -1;
  List truckList = [];
  List deviceIdList = [];
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
    truckList.clear();
    deviceIdList.clear();
    for (var device in devices) {
      setState(() {
        truckList.add(device.truckno);
        // truckList.add("123456");
        // truckList.add("1234567");
        // truckList.add("1234568");
        // truckList.add("123456*");
        print(truckList);
        deviceIdList.add(device.deviceId);
        print(deviceIdList);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTruckList();
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
            child: Stack(
              children: [
                Column(children: [
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
                      HeadingTextWidget('selectTruck'.tr),
                    ],
                  ),
                  SizedBox(
                    height: space_3,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: space_3, horizontal: space_3),
                    child: Container(
                      height: space_11,
                      decoration: BoxDecoration(
                        color: widgetBackGroundColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 0.8, color: widgetBackGroundColor),
                      ),
                      child: TextField(
                        onTap: () {
                          // Get.to(() => MyTrucksResult(
                          //       gpsDataList: gpsDataList,
                          //       deviceList: devicelist,
                          //       //truckAddressList: truckAddressList,
                          //       status: status,
                          //       items: items,
                          //     ));
                          // print("Enterrr");
                          // print("THE ITEMS $items");
                        },
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'searchByNumber'.tr,
                          icon: Padding(
                            padding: EdgeInsets.only(left: space_2),
                            child: Icon(
                              Icons.search,
                              color: grey,
                            ),
                          ),
                          hintStyle: TextStyle(
                            fontSize: size_8,
                            color: grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: ListView.builder(
                        itemCount: truckList.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                selectedTruck = truckList[index];
                                selectedDeviceId = deviceIdList[index];
                                print(selectedDeviceId);
                              });
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: space_8,
                                          right: space_5,
                                          bottom: space_4,
                                          top: space_3),
                                      child: !(index == selectedIndex)
                                          ? Container(
                                              // color: grey,
                                              height: 15,
                                              width: 15,
                                              padding: EdgeInsets.fromLTRB(
                                                  space_2, space_2, 0, 0),
                                              decoration: BoxDecoration(
                                                // color: grey,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/icons/deepbluecircle_ic.png"),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              // color: grey,
                                              height: 25,
                                              width: 25,
                                              padding: EdgeInsets.fromLTRB(
                                                  space_2, space_2, 0, 0),
                                              decoration: BoxDecoration(
                                                // color: grey,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/icons/greencheckcircle_ic.png"),
                                                ),
                                              ),
                                            ),
                                    ),
                                    // setState
                                    // changes(),
                                    Text(
                                      truckList[index],
                                      style: TextStyle(
                                        fontSize: size_10,
                                        fontWeight: mediumBoldWeight,
                                        color: black,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: space_5, right: space_5),
                                  child: Divider(
                                    height: size_10,
                                    color: grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ]),
                // ),
                Positioned(
                  bottom: 50,
                  right: 0,
                  // alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      print(selectedTruck);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return ConfirmBookingDetails(
                          selectedTruck: selectedTruck,
                          selectedDeviceId: selectedDeviceId,
                          driverName: widget.driverName,
                          mobileNo: widget.driverPhoneNo,
                          loadDetailsScreenModel: widget.loadDetailsScreenModel,
                          directBooking: true,
                        );
                      })));
                    },
                    // onTap: widget.truckId != null
                    //     ? () {
                    //         getBookingData();
                    //       }
                    //     : null,
                    child: Container(
                      // color: grey,
                      margin: EdgeInsets.only(right: space_3),
                      height: space_9 + 1,
                      width: 130,
                      decoration: BoxDecoration(
                          // color: widget.truckId != null ?
                          // darkBlueColor : unselectedGrey,
                          color: darkBlueColor,
                          borderRadius: BorderRadius.circular(radius_4)),
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: white,
                              fontWeight: mediumBoldWeight,
                              fontSize: size_8 + 2),
                        ),
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

  // changes() {
  //   setState(() {
  //     selectedIndex = false;
  //   });
  // }
}
