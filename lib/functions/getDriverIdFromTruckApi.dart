/*import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/models/truckModel.dart';
import 'dart:convert';
TransporterIdController tIdController = Get.find<TransporterIdController>();
var jsonData;
List driverIdList=[];
String truckApiUrl =
    "http://ec2-3-7-133-111.ap-south-1.compute.amazonaws.com:9090/truck";
Future<List> getTruckNoFromTruckApi() async {
  http.Response response = await http.get(Uri.parse(
      truckApiUrl + '?transporterId=${tIdController.transporterApproved}'));
  jsonData = json.decode(response.body);

  for (var json in jsonData) {
    driverIdList.add(json["driverId"]);
  }
  return driverIdList;
}
*/