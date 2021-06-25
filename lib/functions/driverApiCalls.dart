import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/models/truckModel.dart';
import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'package:liveasy/models/driverModel.dart';

class DriverApiCalls {
  List<DriverModel> driverList = [];

  List? jsonData;

  TransporterIdController transporterIdController =
  Get.find<TransporterIdController>();

  final String driverApiUrl = FlutterConfig.get('driverApiUrl');

  //GET DRIVERS BY TRANSPORTER ID-----------------------------------------------

  Future<List> getDriversByTransporterId() async {
    http.Response response = await http.get(Uri.parse(
        '$driverApiUrl?transporterId=${transporterIdController.transporterId.value}'));

    jsonData = json.decode(response.body);

    for (var json in jsonData!) {
      DriverModel driverModel = DriverModel();
      driverModel.driverId = json["driverId"];
      driverModel.transporterId = json["transporterId"];
      driverModel.phoneNum = json["phoneNum"];
      driverModel.driverName = json["driverName"];
      driverModel.truckId = json["truckId"];
      driverList.add(driverModel);
    }

    print(driverList);
    return driverList;
  }

  //----------------------------------------------------------------------------

  Future<dynamic> getDriverByDriverId(
      {String? driverId, TruckModel? truckModel}) async {
    Map? jsonData;

    if (driverId != null) {
      http.Response response =
      await http.get(Uri.parse('$driverApiUrl/$driverId'));

      Map jsonData = json.decode(response.body);

      DriverModel driverModel = DriverModel();
      driverModel.driverId = jsonData["driverId"];
      driverModel.transporterId = jsonData["transporterId"];
      driverModel.phoneNum = jsonData["phoneNum"];
      driverModel.driverName = jsonData["driverName"];
      driverModel.truckId = jsonData["truckId"];

      return driverModel;
    }

    if (truckModel!.driverId != null) {
      http.Response response =
      await http.get(Uri.parse('$driverApiUrl/${truckModel.driverId}'));

      jsonData = json.decode(response.body);
    }

    TruckModel truckModelFinal = TruckModel(truckApproved: false);
    truckModelFinal.driverName =
    truckModel.driverId != null ? jsonData!['driverName'] : 'NA';
    truckModelFinal.truckApproved = truckModel.truckApproved;
    truckModelFinal.truckNo = truckModel.truckNo;
    truckModelFinal.truckType = truckModel.truckType;
    truckModelFinal.tyres = truckModel.tyres;
    truckModelFinal.driverNum =
    truckModel.driverId != null ? jsonData!['phoneNum'] : 'NA';

    return truckModelFinal;
  }
  //POST DRIVER-----------------------------------------------------------------

  postDriverApi(driverName, phoneNum, transporterId, truckId) async {
    Map data = {
      "driverName": driverName,
      "phoneNum": phoneNum,
      "transporterId": transporterId,
      "truckId": truckId
    };
    String body = json.encode(data);
    // final String driverApiUrl = FlutterConfig.get('driverApiUrl').toString();
    final response = await http.post(Uri.parse("$driverApiUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
  }
}
