import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:liveasy/controller/transporterIdController.dart';
import 'dart:convert';

import 'package:liveasy/models/driverModel.dart';

var jsonData;
List driverDetailsList = [];
TransporterIdController tIdController = Get.find<TransporterIdController>();
String driverApiUrl =
    "http://ec2-15-207-113-71.ap-south-1.compute.amazonaws.com:9080/driver";

Future<List> getDriverDetailsFromDriverApi() async {
  http.Response response = await http.get(Uri.parse(
      driverApiUrl + '?transporterId=${tIdController.transporterId}'));
  jsonData = json.decode(response.body);

  for (var json in jsonData) {
    DriverModel driverModel = DriverModel();
    driverModel.driverId = json["driverId"];
    driverModel.transporterId = json["transporterId"];
    driverModel.phoneNum = json["phoneNum"];
    driverModel.driverName = json["driverName"];
    driverModel.truckId = json["truckId"];
    driverDetailsList.add(driverModel);
  }

  print(driverDetailsList);
  return driverDetailsList;
}
