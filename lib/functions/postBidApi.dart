import 'dart:convert';
import 'package:http/http.dart' as http;

postBidAPi(loadId, rate, transporterIdController,unit) async {
  Map data = {
    "transporterId": transporterIdController,
    "loadId": loadId,
    "rate": rate,
    //"unit":unit,
    "transporterApproval": true,
    "shipperApproval": false
  };
  String body = json.encode(data);

  final response = await http.post(
      Uri.parse(
          "http://ec2-15-207-113-71.ap-south-1.compute.amazonaws.com:8080/bid"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body);
  print(loadId);
}
