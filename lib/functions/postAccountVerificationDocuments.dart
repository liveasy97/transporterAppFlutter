import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:liveasy/controller/transporterIdController.dart';

Future<String> postAccountVerificationDocuments(
    {String? profilePhoto,
      String? addressProofFront,
      String? addressProofBack,
      String? panFront,
      String? companyIdProof}) async {
  TransporterIdController transporterIdController =
  Get.find<TransporterIdController>();
  try {
    print("I am Posting this");
    final String documentApiUrl =
        FlutterConfig.get("documentApiUrl").toString();
    Map data = {
      "documents": [
        {
          "data": profilePhoto,
          "documentType": "Profile Photo",
          "verified": true
        },
        {
          "data": addressProofFront,
          "documentType": "Address Proof Front Photo",
          "verified": true
        },
        {
          "data": addressProofBack,
          "documentType": "Address Proof Back Photo",
          "verified": true
        },
        {
          "data": panFront,
          "documentType": "ID Proof (Pan Card)Front Photo",
          "verified": true
        },
        {
          "data": companyIdProof,
          "documentType": "Company ID Proof Photo",
          "verified": true
        }
      ],
      "entityId": transporterIdController.transporterId.value
    };
    String body = json.encode(data);

    final response = await http.post(Uri.parse(documentApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      return "Error ${response.statusCode} \n Printing Response ${response.body}";
    }
  } catch (e) {
    print("Error is $e");
    Get.snackbar("Error", "$e", snackPosition: SnackPosition.BOTTOM);
  }
  return "Success";
}
