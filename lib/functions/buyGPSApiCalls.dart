import 'package:get/get.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BuyGPSApiCalls {
  final String buyGPSApiUrl = FlutterConfig.get('buyGPSApiUrl');
  // transporterId controller
  TransporterIdController transporterIdController = Get.find<TransporterIdController>();

  String? _gpsId;

  Future<String?> postByGPSData({required String? truckId, required String? address, required String? rate, required String? duration}) async {

    // json map
    Map<String, dynamic> data = {
      "transporterId": transporterIdController.transporterId.value,
      "truckId": truckId,
      "rate": rate,
      "duration": duration,
      "address": address
    };

    String body = json.encode(data);

    //post request
    http.Response response = await http.post(Uri.parse(buyGPSApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    print("Response is ${response.body}");
    var returnData = json.decode(response.body);

    _gpsId = returnData['gpsId'];

    return _gpsId;
  }

}