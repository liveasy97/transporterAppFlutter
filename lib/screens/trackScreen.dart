import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:liveasy/constants/borderWidth.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liveasy/functions/mapUtils/getLoactionUsingImei.dart';
import 'package:liveasy/widgets/Header.dart';
import 'package:liveasy/widgets/buttons/helpButton.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:logger/logger.dart';
import 'package:geocoding/geocoding.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class TrackScreen extends StatefulWidget {
  final List gpsData;
  final String? TruckNo;
  final String? imei;
  final String? driverNum;
  final String? driverName;

  TrackScreen({
    required this.gpsData,
    this.TruckNo,
    this.driverName,
    this.driverNum,
    this.imei});

  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  final Set<Polyline> _polyline = {};
  Map<PolylineId, Polyline> polylines = {};
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
  late List newGPSData;
  late List reversedList;
  late List oldGPSData;
  MapUtil mapUtil = MapUtil();
  List<LatLng> latlng = [];
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  late PointLatLng start;
  late PointLatLng end;
  String? truckAddress;
  String? truckDate;
  String? Speed;
  String googleAPiKey = "AIzaSyBLJ8zwqBOM7yK_FYqGuKsiv8_huRvQwe8";
  @override
  void initState() {
    super.initState();
    try {
      initfunction();
      getCurrentLocation();
      logger.i("in init state function");
      lastlatLngMarker = LatLng(widget.gpsData.last.lat, widget.gpsData.last.lng);
      camPosition = CameraPosition(
          target: lastlatLngMarker,
          zoom: 8.0
      );
    } catch (e) {
      logger.e("Error is $e");
    }
  }

  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission != PermissionStatus.granted)
        getLocation();
      return;
    }
    getLocation();
  }

  getLocation() async {
    LatLng? latlong;
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    start = PointLatLng(position.latitude, position.longitude);
    end = PointLatLng(widget.gpsData.last.lat, widget.gpsData.last.lng);
    setState(() {
      latlong = LatLng(position.latitude, position.longitude);
      BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
          'assets/icons/mantransman.png')
          .then((value) => {
        setState(() {
          pinLocationIcon = value;
          customMarkers.add(Marker(
              markerId: MarkerId("Transporter Mark"),
              position: latlong!,
              infoWindow: InfoWindow(title: "Your Location"),
              icon: pinLocationIcon));
        }),
      });
    });
    print("Start 1 is $start");
    print("End  1 is $end");
    _getPolyline(start, end);
  }
  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      visible: true,
    );
    setState(() {
      polylines[id] = polyline;
      _polyline.add(polyline);
    });
  }
  _getPolyline(PointLatLng start, PointLatLng end) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      start,
      end,
      travelMode: TravelMode.driving
    );
    print("Error message is ${result.errorMessage}");
    print("Result status is ${result.status}");
    polylineCoordinates.clear();
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        setState(() {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        PolylineId id = PolylineId('poly');
        Polyline polyline = Polyline(
          polylineId: id,
          color: loadingWidgetColor,
          points: polylineCoordinates,
          width: 5,
        );
        setState(() {
          polylines[id] = polyline;
        });
      });
    } else {
      print("It is empty");
    }
    _addPolyLine();
  }

  _makingPhoneCall() async {

    String url = 'tel:${widget.driverNum}';
    UrlLauncher.launch(url);
  }

  void initfunction() async {
    var gpsData = await mapUtil.getLocationByImei(imei: widget.imei);
    setState(() {
      newGPSData = gpsData;
      oldGPSData = newGPSData.reversed.toList();
    });
    List<Placemark> placemarks = await placemarkFromCoordinates(widget.gpsData.last.lat, widget.gpsData.last.lng);
    var somei = widget.gpsData.last.gpsTime;
    var timestamp = somei.toString().replaceAll(" ", "").replaceAll("-", "").replaceAll(":", "");
    var year = timestamp.substring(0, 4);
    var month = int.parse(timestamp.substring(4, 6));
    var day = timestamp.substring(6, 8);
    var hour = int.parse(timestamp.substring(8, 10));
    var minute = int.parse(timestamp.substring(10, 12));
    var monthname  = DateFormat('MMM').format(DateTime(0, month));
    var ampm  = DateFormat.jm().format(DateTime(0, 0, 0, hour, minute));
    setState(() {
      truckDate = "$ampm, $day $monthname $year";
      print("Truck date is $truckDate");
    });
    print(placemarks);
    Placemark place = placemarks[0];
    var street = place.street;
    var sublocality = place.subLocality;
    var locality = place.locality;
    var district = place.subAdministrativeArea;
    var state = place.administrativeArea;
    var postalCode = place.postalCode;
    var country = place.country;
    setState(() {
      truckAddress = '$street, $sublocality, $locality, $district, $state, $postalCode, $country';
    });
    if (truckAddress!.contains(", ,")) {
      print("True");
      setState(() {
        truckAddress = truckAddress!.replaceAll(", ,", ",");
      });
      print("New truck Address is $truckAddress");
    } else {
      print("Do nothing");
    }
    print("Address is $truckAddress");
    iconthenmarker();
  }

  void iconthenmarker() {
    logger.i("in Icon maker function");
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icons/truckpin.png')
        .then((value) => {
      setState(() {
        pinLocationIcon = value;
      }),
      createmarker()
    });
  }

  void createmarker() async {
    try {
      final GoogleMapController controller = await _controller.future;
      LatLng latLngMarker =
      LatLng(newGPSData.last.lat, newGPSData.last.lng);
      String? title = widget.TruckNo;
      setState(() {
        lastlatLngMarker = LatLng(newGPSData.last.lat, newGPSData.last.lng);
        latlng.add(lastlatLngMarker);
        customMarkers.add(Marker(
            markerId: MarkerId(newGPSData.last.id.toString()),
            position: latLngMarker,
            infoWindow: InfoWindow(title: title),
            icon: pinLocationIcon));
        _polyline.add(Polyline(
          polylineId: PolylineId(newGPSData.last.id.toString()),
          visible: true,
          points: polylineCoordinates,
          color: Colors.blue,
        ));
      });
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: lastlatLngMarker,
          zoom: 8.0,
        ),
      ));
    } catch (e) {
      print("Exceptionis $e");
    }
  }

  @override
  void dispose() {
    logger.i("Activity is disposed");
    timer.cancel();
    super.dispose();
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
                          text: 'Location Tracking',
                          backButton: true
                      ),
                    ),
                    HelpButtonWidget()
                  ],
                ),
              ),
              Container(
                // width: 250,
                // height: 500,
                height: 375,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  markers: customMarkers.toSet(),
                  // polylines: _polyline,
                  polylines: Set.from(polylines.values),
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  initialCameraPosition: camPosition,
                  compassEnabled: true,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              Container(
                height: 245,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)
                  )
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: space_11,
                      decoration : BoxDecoration(
                        color: greyBox,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)
                          )
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(bottom: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${widget.driverName}",
                            style: TextStyle(
                              color: textBlack,
                              fontSize: size_7,
                              fontStyle: FontStyle.normal,
                              fontWeight: mediumBoldWeight
                            ),
                          ),
                          SizedBox(
                            width: 15
                          ),
                          Row(
                            children: [
                              InkWell(
                                child: Container(
                                  height: space_5,
                                  width: space_16,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(width: borderWidth_10, color: darkBlueColor)),
                                  padding: EdgeInsets.only(left: (space_3 - 1), right: (space_3 - 2)),
                                  margin: EdgeInsets.only(right: (space_3)),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: space_3,
                                          width: space_3,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage("assets/icons/callButtonIcon.png"))),
                                        ),
                                        SizedBox(
                                          width: space_1,
                                        ),
                                        Text(
                                          "Call",
                                          style: TextStyle(fontSize: size_7, color: darkBlueColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _makingPhoneCall();
                                },
                              ),
                              GestureDetector(
                                onTap: () => null,
                                child: Image.asset('assets/icons/goicon.png', width: 22, height: 22,),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Speed",
                                style: TextStyle(
                                  color: textBlack,
                                  fontSize: size_6,
                                  fontWeight: mediumBoldWeight,
                                ),
                              ),
                              SizedBox(
                                height: 10
                              ),
                              Text(
                                "${newGPSData.last.speed}",
                                style: TextStyle(
                                  color: textBlack,
                                  fontSize: size_6,
                                  fontWeight: regularWeight,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Travelled",
                                style: TextStyle(
                                  color: liveasyGreen,
                                  fontSize: size_6,
                                  fontWeight: mediumBoldWeight,
                                ),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Text(
                                "1620.4 km",
                                style: TextStyle(
                                  color: textBlack,
                                  fontSize: size_6,
                                  fontWeight: regularWeight,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Stoppage",
                                style: TextStyle(
                                  color: declineButtonRed,
                                  fontSize: size_6,
                                  fontWeight: mediumBoldWeight,
                                ),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                  color: textBlack,
                                  fontSize: size_6,
                                  fontWeight: regularWeight,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                  'assets/icons/currentlocationicon.png',
                                  width: 22,
                                  height: 22,
                              ),
                              SizedBox(
                                width: 10
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 233,
                                    child: Text(
                                      "$truckAddress",
                                      style: TextStyle(
                                        color: textBlack,
                                        fontSize: size_6,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: normalWeight
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 180,
                                    child: Text(
                                      "$truckDate",
                                      style: TextStyle(
                                          color: textBlack,
                                          fontSize: size_6,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: regularWeight
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                        margin: EdgeInsets.only(top: 15),
                        width: 345,
                        height: 0.4,
                        decoration: BoxDecoration(
                          color: textBlack,
                        )
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: (space_4 + 2),
                                width: (space_4 + 2),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/icons/playicon.png"))),
                              ),
                              SizedBox(
                                width: space_2,
                              ),
                              Text(
                                "Play trip history",
                                style: TextStyle(
                                    fontSize: size_6,
                                    color: bidBackground,
                                    fontWeight: mediumBoldWeight,
                                    fontStyle: FontStyle.normal
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              print("tapped");
                              },
                            child: Container(
                              width: 130,
                              height: 30,
                              decoration: BoxDecoration(
                                color: bidBackground,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "See history",
                                style: TextStyle(
                                  color: white,
                                  fontSize: size_6,
                                  fontWeight: mediumBoldWeight,
                                  fontStyle: FontStyle.normal
                              )
                              )
                            ),
                          ),
                        ]
                      ),
                    )
                  ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}