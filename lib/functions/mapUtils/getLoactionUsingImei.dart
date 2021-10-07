import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:liveasy/models/gpsDataModel.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:geocoding/geocoding.dart';

class MapUtil {
  String gpsApiUrl = FlutterConfig.get("gpsApiUrl");

  getLocationByImei({String? imei}) async {
    print("getLocationByImei got called with imei : $imei");
    try {
      print("$gpsApiUrl/$imei");
      // http.Response response = await http.get(Uri.parse("$gpsApiUrl/transporter:a86719af-7104-4917-ac04-d712bc766cb3"));
      http.Response response = await http.get(Uri.parse("$gpsApiUrl/355172100788965"));
      print(response.statusCode);
      print(response.body);
      var jsonData = await jsonDecode(response.body);
      var LatLongList = [];
      if (response.statusCode == 200) {
        for (var json in jsonData) {
          GpsDataModel gpsDataModel = new GpsDataModel();
          gpsDataModel.id = json["id"] != null ? json["id"] : 'NA';
          gpsDataModel.imei = json["imei"] != null ? json["imei"] : 'NA';
          gpsDataModel.lat = double.parse(json["lat"] != null ? json["lat"] : 0);
          gpsDataModel.lng = double.parse(json["lng"] != null ? json["lng"] : 0);
          gpsDataModel.speed = json["speed"] != null ? json["speed"] : 'NA';
          gpsDataModel.deviceName = json["deviceName"] != null ? json["deviceName"] : 'NA';
          print("Device Name is ${gpsDataModel.deviceName}");
          gpsDataModel.powerValue = json["powerValue"] != null ? json["powerValue"] : 'NA';
          gpsDataModel.direction = json["direction"] != null ? json["direction"] : 'NA';
          gpsDataModel.timestamp = json["timeStamp"] != null ? json["timeStamp"] : 'NA';
          gpsDataModel.gpsTime = json["gpsTime"] != null ? json["gpsTime"] : 'NA';
          LatLongList.add(gpsDataModel);
        }
        return LatLongList;
      }
      else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  getLocationHistoryByImei({String? imei, String? starttime, String? endtime}) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "$gpsApiUrl?imei=$imei&startTime=$starttime&endTime=$endtime"
      ));
      print("Response Body is ${response.body}");
      print("Response status code is ${response.statusCode}");
      var jsonData = await jsonDecode(response.body);
      var LatLongList = [];
      if (response.statusCode == 200) {
        for (var json in jsonData) {
          GpsDataModel gpsDataModel = new GpsDataModel();
          gpsDataModel.id = json["id"] != null ? json["id"] : 'NA';
          print("ID is ${gpsDataModel.id}");
          gpsDataModel.imei = json["imei"] != null ? json["imei"] : 'NA';
          gpsDataModel.lat = double.parse(json["lat"] != null ? json["lat"] : 0);
          gpsDataModel.lng = double.parse(json["lng"] != null ? json["lng"] : 0);
          var latn = gpsDataModel.lat = double.parse(json["lat"] != null ? json["lat"] : 0);
          var lngn = gpsDataModel.lng = double.parse(json["lng"] != null ? json["lng"] : 0);
          var placemark = placemarkFromCoordinates(latn, lngn);
          List<Placemark> newPlace = await placemark;
          Placemark placeMark  = newPlace[0];
          String? name = placeMark.name;
          String? subLocality = placeMark.subLocality;
          String? locality = placeMark.locality;
          String? administrativeArea = placeMark.administrativeArea;
          String? postalCode = placeMark.postalCode;
          String? country = placeMark.country;
          String? addressstring = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
          print(addressstring);
          gpsDataModel.address = addressstring;
          gpsDataModel.speed = json["speed"] != null ? json["speed"] : 'NA';
          gpsDataModel.deviceName = json["deviceName"] != null ? json["deviceName"] : 'NA';
          gpsDataModel.powerValue = json["powerValue"] != null ? json["powerValue"] : 'NA';
          gpsDataModel.direction = json["direction"] != null ? json["direction"] : 'NA';
          LatLongList.add(gpsDataModel);
        }
        return LatLongList;
      }
      else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}