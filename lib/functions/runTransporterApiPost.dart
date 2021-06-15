import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:liveasy/controller/transporterIdController.dart';


void runTransporterApiPost({required String mobileNum, String? userLocation}) async {
  TransporterIdController transporterIdController = Get.put(TransporterIdController());
  final String transporterApiUrl = FlutterConfig.get("transporterApiUrl").toString();
  Map data = userLocation != null? {
    "phoneNo": mobileNum,
    "transporterLocation": userLocation
  } : {
    "phoneNo": mobileNum
  };
  String body = json.encode(data);
  final response = await http.post(Uri.parse(transporterApiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body);
  if (response.statusCode == 200) {
    print(response.body);
    String transporterId = json.decode(response.body)["transporterId"];
    bool transporterApproved = json.decode(response.body)["transporterApproved"].toString() == "true";
    bool companyApproved = json.decode(response.body)["companyApproved"].toString() == "true";
    transporterIdController.updateTransporterId(transporterId);
    transporterIdController.updateTransporterApproved(transporterApproved);
    transporterIdController.updateCompanyApproved(companyApproved);
    transporterIdController.updateMobileNum(mobileNum);
  }
}