import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:liveasy/controller/transporterIdController.dart';
import 'dart:convert';
TransporterIdController tIdController = Get.find<TransporterIdController>();
var jsonData;
List truckNoList=[];
String truckApiUrl =
    "http://ec2-3-7-133-111.ap-south-1.compute.amazonaws.com:9090/truck";
  Future<List> getTruckNoFromTruckApi() async {
    http.Response response = await http.get(Uri.parse(
        truckApiUrl + '?transporterId=transporter:f285cd0f-f8c3-4852-bf0b-a737bedd3cf4'));
    jsonData = json.decode(response.body);

    for (var json in jsonData) {
      truckNoList.add(json["truckNo"]);
    }
    return truckNoList;
  }
