import 'dart:async';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liveasy/functions/mapUtils/getLoactionUsingImei.dart';
import 'package:liveasy/widgets/Header.dart';
import 'package:liveasy/widgets/buttons/helpButton.dart';
import 'package:logger/logger.dart';
import 'package:screenshot/screenshot.dart';

class HistoryScreen extends StatefulWidget {
  final String? TruckNo;
  final String? imei;

  HistoryScreen({this.TruckNo, this.imei});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final List<PointLatLng> polylinePoints;
  late GoogleMapController _googleMapController;
  late LatLng lastlatLngMarker;
  Iterable markers = [];
  ScreenshotController screenshotController = ScreenshotController();
  late BitmapDescriptor pinLocationIcon;
  late CameraPosition camPosition;
  var logger = Logger();
  late Marker markernew;
  List<Marker> customMarkers = [];
  late Timer timer;
  Completer<GoogleMapController> _controller = Completer();
  List? newGPSData;
  MapUtil mapUtil = MapUtil();
  String? startTime;
  String? endTime;
  final now = DateTime.now();
  String sendTime = DateFormat('yyyyMMdd:HHmmss').format(DateTime.now());
  TextEditingController hourscontroller = TextEditingController();
  TextEditingController minutescontroller = TextEditingController();
  TextEditingController dayscontroller = TextEditingController();

  void getHistory(var endtime) async {
    print("IMei is ${widget.imei}");
    var gpsDataInitial = await mapUtil.getLocationHistoryByImei(
      imei: widget.imei,
      starttime: sendTime,
      endtime: endtime
    );
    setState(() {
      newGPSData = gpsDataInitial;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: statusBarColor,
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF525252),
      //   title: ,
      // ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, space_4, 0, 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: space_4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(space_3, 0, space_3, 0),
                      child: Header(
                          reset: false,
                          text: 'Location History',
                          backButton: true
                      ),
                    ),
                    HelpButtonWidget()
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  "From Date and Time"
              ),
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                // dateMask: 'd MMM, yyyy',
                // dateMask: 'yyyy MM dd : HH mm ss',
                // dateMask: "d MMMM, yyyy - hh:mm a",
                dateMask: 'dd/MM/yyyy - hh:mm',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(DateTime.now().year),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }

                  return true;
                },
                onChanged: (val) {
                  print("$val onchanged");
                  try {
                    var trim = val.toString().trim();
                    var trimrm = trim.replaceAll("-", "").replaceAll(" ", "").replaceAll(":", "");
                    var trimfinal = trimrm.substring(0, 8) + ":" + trimrm.substring(8,12) + "00";
                    setState(() {
                      startTime = trimfinal;
                    });
                    print("selected date 1 is $trimfinal");
                  } catch (e) {
                    print("Exception is $e");
                  }
                },
                validator: (val) {
                  print("$val validator");
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  "To Date and Time"
              ),
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                dateMask: 'dd/MM/yyyy - hh:mm',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(DateTime.now().year),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }

                  return true;
                },
                onChanged: (val) {
                  print("$val onchanged");
                  try {
                    var trim = val.toString().trim();
                    var trimrm = trim.replaceAll("-", "").replaceAll(" ", "").replaceAll(":", "");
                    var trimfinal = trimrm.substring(0, 8) + ":" + trimrm.substring(8,12) + "00";
                    print("selected date 1 is $trimfinal");
                    setState(() {
                      endTime = trimfinal;
                    });
                  } catch (e) {
                    print("Exception is $e");
                  }
                },
                validator: (val) {
                  print("$val validator");
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              newGPSData != null
              ? Container(
                height: 300,
                child: ListView.builder(
                    padding: EdgeInsets.only(bottom: space_15),
                    // controller: scrollController,
                    itemCount: newGPSData!.length,
                    itemBuilder: (context, index) {
                      return Text(
                          "${newGPSData![index].address}"
                      );
                    }),
              )
                  : Text("No data available"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () {
          logger.i("Working on click in refresh button");
          // onRefreshPressed()
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
