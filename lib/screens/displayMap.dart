import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liveasy/functions/mapUtils/getLoactionUsingImei.dart';
import 'package:liveasy/widgets/Header.dart';
import 'package:liveasy/widgets/buttons/helpButton.dart';
import 'package:location_permissions/location_permissions.dart';
// import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:screenshot/screenshot.dart';

class DisplayHistory extends StatefulWidget {
  final List gpsData;
  final String? TruckNo;
  final String? imei;

  DisplayHistory({required this.gpsData, this.TruckNo, this.imei});

  @override
  _DisplayHistoryState createState() => _DisplayHistoryState();
}

class _DisplayHistoryState extends State<DisplayHistory> {
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
          zoom: 11
      );
      timer = Timer.periodic(Duration(minutes: 1, seconds: 10), (Timer t) => onActivityExecuted());
      // Iterable _markers = Iterable.generate(1, (index) {
      //   logger.i("Index is $index");
      //   LatLng latLngMarker =
      //   LatLng(widget.gpsData.last.lat, widget.gpsData.last.lng);
      //   logger.i("LatLong is $latLngMarker");
      //   String title = index.toString();
      //   return Marker(
      //       markerId: MarkerId("marker$index"),
      //       position: latLngMarker,
      //       infoWindow: InfoWindow(title: title),
      //       icon: pinLocationIcon);
      // });
      // setState(() {
      //   firstlatLngMarker =
      //       LatLng(widget.gpsData[0].lat, widget.gpsData[0].lng);
      //   markers = _markers;
      // });
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
    double _originLatitude = 26.48424, _originLongitude = 50.04551;
    double _destLatitude = 26.46423, _destLongitude = 50.06358;
    var thisone = PointLatLng(_originLatitude, _originLongitude);
    var thistwo = PointLatLng(_destLatitude, _destLongitude);
    print("This one is $thisone");
    print("This two is $thistwo");
    print("Start is $start");
    print("Start is $end");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      start,
      end,
      // thisone,
      // thistwo,
      travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    print("Error message is ${result.errorMessage}");
    print("Result status is ${result.status}");
    polylineCoordinates.clear();
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        print("Point above set state is $point");
        setState(() {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        PolylineId id = PolylineId('poly');
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blue,
          points: polylineCoordinates,
          width: 3,
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

  void initfunction() async {
    var gpsData = await mapUtil.getLocationByImei(imei: widget.imei);
    setState(() {
      newGPSData = gpsData;
      oldGPSData = newGPSData.reversed.toList();
      print("Length new init is ${newGPSData.length}");
      print("Length old init is ${oldGPSData.length}");
    });
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
      // _getPolyline(),
      createmarker()
    });
  }

  void iconthenmarkerAfter() {
    logger.i("in Icon maker After function");
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 1),
        'assets/icons/truckpin.png')
        .then((value) => {
      setState(() {
        pinLocationIcon = value;
      }),
      // _getPolyline(),
      createmarkerAfter()
    });
  }

  void onRefreshPressed() async {
    logger.i("Refresh button is pressed");
    var gpsData = await mapUtil.getLocationByImei(imei: widget.imei);
    setState(() {
      newGPSData = gpsData;
      oldGPSData.addAll(newGPSData);
      reversedList = oldGPSData.reversed.toList();
      print("Last lat is ${reversedList[0].lat}");
      print("Length new onrefresh is ${newGPSData.length}");
      print("Length old onrefresh is ${oldGPSData.length}");
      print("Length reversedList onrefresh is ${reversedList.length}");
    });
    iconthenmarker();
  }
  void onActivityExecuted() async {
    logger.i("It is in Activity Executed function");
    var gpsData = await mapUtil.getLocationByImei(imei: widget.imei);
    setState(() {
      newGPSData = gpsData;
      oldGPSData = newGPSData.reversed.toList();
      print("Length new 1 minute is ${newGPSData.length}");
      print("Length old 1 minute is ${oldGPSData.length}");
    });
    iconthenmarkerAfter();
  }

  void createmarker() async {
    try {
      final GoogleMapController controller = await _controller.future;
      logger.i("in Create maker function");
      LatLng latLngMarker =
      LatLng(newGPSData.last.lat, newGPSData.last.lng);
      print("Lay long is $lastlatLngMarker");
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
          //latlng is List<LatLng>
          points: polylineCoordinates,
          color: Colors.blue,
        ));
      });
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: lastlatLngMarker,
          zoom: 11.0,
        ),
      ));
    } catch (e) {
      print("Exceptionis $e");
    }
  }

  void createmarkerAfter() async {
    final GoogleMapController controller = await _controller.future;
    logger.i("in Create maker After function");
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
        polylineId: PolylineId("newGPSData.last.id.toString()"),
        visible: true,
        //latlng is List<LatLng>
        points: polylineCoordinates,
        color: Colors.blue,
      ));

    });
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: lastlatLngMarker,
        zoom: 11.0,
      ),
    ));
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
                height: MediaQuery.of(context).size.height - 98,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  // markers: Set.from(
                  //     markers
                  // ),
                  // markers: Set.from(markers),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => {
          logger.i("Working on click in refresh button"),
          onRefreshPressed()
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

}