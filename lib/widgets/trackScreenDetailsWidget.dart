import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/borderWidth.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/dynamicLink.dart';
import 'package:liveasy/functions/BackgroundAndLocation.dart';
import 'package:liveasy/screens/playRouteHistoryScreen.dart';
import 'package:liveasy/screens/truckHistoryScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackScreenDetails extends StatefulWidget {
  final String? driverNum;
  final String? TruckNo;
  final String? driverName;
  String? dateRange;
  var gpsData;
  var gpsTruckRoute;
  var gpsDataHistory;
  var gpsStoppageHistory;
  var stops;
  var totalRunningTime;
  var totalStoppedTime;
  var deviceId;
  var truckId;
  var totalDistance;

  TrackScreenDetails({
    required this.gpsData,
    required this.gpsTruckRoute,
    required this.gpsDataHistory,
    required this.gpsStoppageHistory,
    required this.driverNum,
    required this.dateRange,
    required this.TruckNo,
    required this.driverName,
    required this.stops,
    required this.totalRunningTime,
    required this.totalStoppedTime,
    required this.deviceId,
    required this.truckId,
    required this.totalDistance,
  });

  @override
  _TrackScreenDetailsState createState() => _TrackScreenDetailsState();
}

class _TrackScreenDetailsState extends State<TrackScreenDetails> {
  var gpsData;
  var gpsTruckRoute;
  var gpsDataHistory;
  var gpsStoppageHistory;
  var stops;
  var totalRunningTime;
  var totalStoppedTime;
  var latitude;
  var longitude;
  @override
  void initState() {
    super.initState();
    initFunction();
    timer = Timer.periodic(
        Duration(minutes: 0, seconds: 20), (Timer t) => initFunction());
  }

  initFunction() async {
    //  print("ppppp ${widget.totalRunningTime}");
    setState(() {
      gpsData = widget.gpsData;
      gpsTruckRoute = widget.gpsTruckRoute;
      gpsDataHistory = widget.gpsDataHistory;
      gpsStoppageHistory = widget.gpsStoppageHistory;
      stops = widget.stops;
      totalRunningTime = widget.totalRunningTime;
      totalStoppedTime = widget.totalStoppedTime;
      latitude = gpsData.last.latitude;
      longitude = gpsData.last.longitude;
    });

    print("speed2 ${gpsData.last.speed}");
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 2.3 + 20,
      width: width,
      padding: EdgeInsets.fromLTRB(0, 0, 0, space_4),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: darkShadow,
              offset: const Offset(
                0,
                -5.0,
              ),
              blurRadius: 15.0,
              spreadRadius: 10.0,
            ),
            BoxShadow(
              color: white,
              offset: const Offset(0, 1.0),
              blurRadius: 0.0,
              spreadRadius: 2.0,
            ),
          ]),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: const Color(0xFFCBCBCB),
              // height: size_3,
              thickness: 3,
              indent: 150,
              endIndent: 150,
            ),
            Container(
              // height: space_11,

              padding: EdgeInsets.fromLTRB(size_10, size_3, 0, space_3),

              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  color: bidBackground,
                                  size: 15,
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: width / 2 + 10,
                                  child: Text(
                                    "${gpsData.last.address}",
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: normalWeight),
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                //  textDirection:
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/circle-outline-with-a-central-dot.png',
                                    color: bidBackground,
                                    width: 11,
                                    height: 11,
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Ignition ",
                                        softWrap: true,
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 12,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: regularWeight)),
                                  ),
                                  (gpsData.last.ignition)
                                      ? Container(
                                          alignment: Alignment.centerLeft,
                                          //    width: 217,

                                          child: Text("ON",
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      : Container(
                                          alignment: Alignment.centerLeft,
                                          //    width: 217,

                                          child: Text("OFF",
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                  SizedBox(),
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/icons/distanceCovered.png'),
                                      height: 14,
                                      width: 14,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      //      width: 103,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Travelled ",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: liveasyGreen,
                                                      fontSize: size_6,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          regularWeight)),
                                              Text("${widget.totalDistance} km",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: black,
                                                      fontSize: size_6,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          regularWeight)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("$totalRunningTime ",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: grey,
                                                      fontSize: size_4,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          regularWeight)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 1,
                                height: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(children: [
                                Icon(Icons.pause, size: 20),
                                SizedBox(
                                  width: space_1,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  //    width: 103,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("${gpsStoppageHistory.length} ",
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: size_6,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: regularWeight)),
                                          Text("Stops",
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: red,
                                                  fontSize: size_6,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: regularWeight)),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("$totalStoppedTime ",
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: grey,
                                                  fontSize: size_4,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: regularWeight)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: space_1,
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                        ] //

                        ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, space_5),
                      child: Column(
                        children: [
                          (widget.gpsData.last.speed > 2)
                              ? Text(
                                  "${(widget.gpsData.last.speed).round()} km/h",
                                  style: TextStyle(
                                      color: liveasyGreen,
                                      fontSize: size_10,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: regularWeight))
                              : Text(
                                  "${(widget.gpsData.last.speed).round()} km/h",
                                  style: TextStyle(
                                      color: red,
                                      fontSize: size_10,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: regularWeight)),
                          Text("Status",
                              style: TextStyle(
                                  color: black,
                                  fontSize: size_6,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: regularWeight))
                        ],
                      ),
                    ),
                    Spacer(),
                  ]),
            ),
            Divider(
              color: black,
              // height: size_3,
              thickness: 0.75,
              indent: size_10,
              endIndent: size_10,
            ),
            Container(
                alignment: Alignment.center,
                // padding: EdgeInsets.only(left: 15, right: 15),
                margin: EdgeInsets.fromLTRB(0, space_1, 0, space_1),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          FloatingActionButton(
                            heroTag: "button1",
                            backgroundColor: bidBackground,
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.near_me_outlined, size: 30),
                            onPressed: () {
                              openMap(gpsData.last.latitude,
                                  gpsData.last.longitude);
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Navigate",
                            style: TextStyle(
                                color: black,
                                fontSize: size_6,
                                fontStyle: FontStyle.normal,
                                fontWeight: mediumBoldWeight),
                          ),
                        ]),
                        SizedBox(
                          height: space_5,
                        ),
                        Column(children: [
                          DynamicLinkService(
                            deviceId: widget.deviceId,
                            truckId: widget.truckId,
                            truckNo: widget.TruckNo,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Share",
                            style: TextStyle(
                                color: black,
                                fontSize: size_6,
                                fontStyle: FontStyle.normal,
                                fontWeight: mediumBoldWeight),
                          ),
                        ]),
                        SizedBox(
                          height: space_5,
                        ),
                        Column(children: [
                          FloatingActionButton(
                            heroTag: "button3",
                            backgroundColor: bidBackground,
                            foregroundColor: Colors.white,
                            child:
                                const Icon(Icons.play_circle_outline, size: 30),
                            onPressed: () {
                              Get.to(PlayRouteHistory(
                                gpsTruckHistory: gpsDataHistory,
                                truckNo: widget.TruckNo,
                                //    routeHistory: gpsTruckRoute,
                                gpsData: gpsData,
                                dateRange: widget.dateRange,
                                gpsStoppageHistory: gpsStoppageHistory,
                                //   totalDistance: totalDistance,
                                totalRunningTime: totalRunningTime,
                                totalStoppedTime: totalStoppedTime,
                              ));
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Play Trip",
                            style: TextStyle(
                                color: black,
                                fontSize: size_6,
                                fontStyle: FontStyle.normal,
                                fontWeight: mediumBoldWeight),
                          ),
                        ]),
                        SizedBox(
                          height: space_5,
                        ),
                        Column(children: [
                          FloatingActionButton(
                            heroTag: "button4",
                            backgroundColor: bidBackground,
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.history, size: 30),
                            onPressed: () {
                              Get.to(TruckHistoryScreen(
                                truckNo: widget.TruckNo,
                                gpsTruckRoute: widget.gpsTruckRoute,
                                dateRange: widget.dateRange,
                                deviceId: widget.deviceId,
                                //     latitude: latitude,
                                //      longitude: longitude,
                              ));
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "History",
                            style: TextStyle(
                                color: black,
                                fontSize: size_6,
                                fontStyle: FontStyle.normal,
                                fontWeight: mediumBoldWeight),
                          ),
                        ]),
                      ],
                    ),

                    // here
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          FloatingActionButton(
                            heroTag: "button1",
                            backgroundColor: bidBackground,
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.near_me_outlined, size: 30),
                            onPressed: () {
                              openMap(gpsData.last.latitude,
                                  gpsData.last.longitude);
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Navigate",
                            style: TextStyle(
                                color: black,
                                fontSize: size_6,
                                fontStyle: FontStyle.normal,
                                fontWeight: mediumBoldWeight),
                          ),
                        ]),
                        SizedBox(
                          height: space_5,
                        ),
                        Column(children: [
                          DynamicLinkService(
                            deviceId: widget.deviceId,
                            truckId: widget.truckId,
                            truckNo: widget.TruckNo,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Share",
                            style: TextStyle(
                                color: black,
                                fontSize: size_6,
                                fontStyle: FontStyle.normal,
                                fontWeight: mediumBoldWeight),
                          ),
                        ]),
                        SizedBox(
                          height: space_5,
                        ),
                        Column(children: [
                          FloatingActionButton(
                            heroTag: "button3",
                            backgroundColor: bidBackground,
                            foregroundColor: Colors.white,
                            child:
                                const Icon(Icons.play_circle_outline, size: 30),
                            onPressed: () {
                              Get.to(PlayRouteHistory(
                                gpsTruckHistory: gpsDataHistory,
                                truckNo: widget.TruckNo,
                                //    routeHistory: gpsTruckRoute,
                                gpsData: gpsData,
                                dateRange: widget.dateRange,
                                gpsStoppageHistory: gpsStoppageHistory,
                                //   totalDistance: totalDistance,
                                totalRunningTime: totalRunningTime,
                                totalStoppedTime: totalStoppedTime,
                              ));
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Play Trip",
                            style: TextStyle(
                                color: black,
                                fontSize: size_6,
                                fontStyle: FontStyle.normal,
                                fontWeight: mediumBoldWeight),
                          ),
                        ]),
                      ],
                    )
                  ],
                ))
          ]),
    );
  }
}
