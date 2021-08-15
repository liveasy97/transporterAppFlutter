import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:intl/intl.dart';

Future<String?> postBidAPi(loadId, rate, transporterIdController, unit) async {
  String now = DateFormat("dd-MM-yyyy").format(DateTime.now());
  var jsondata;

  if (unit == "RadioButtonOptions.PER_TON") {
    unit = "PER_TON";
  }
  if (unit == "RadioButtonOptions.PER_TRUCK") {
    unit = "PER_TRUCK";
  }
  try {
    Map data = {
      "transporterId": transporterIdController.toString(),
      "loadId": loadId.toString(),
      "currentBid": rate.toString(),
      "unitValue": unit.toString(),
      "biddingDate": now.toString(),
      "transporterApproval": true,
      // "shipperApproval": false,
      // "truckId": []
    };
    String body = json.encode(data);
    final String bidApiUrl = FlutterConfig.get('biddingApiUrl').toString();
    final response = await http.post(Uri.parse("$bidApiUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    jsondata = json.decode(response.body);
    if (response.statusCode == 201) {
      return "success";
    } else if (response.statusCode == 409) {
      print(jsondata);
      print(
          "print error in bid conflict===>${jsondata["apierror"]["message"]}");
      return "conflict";
    }
    return "unsuccessful";
  } catch (e) {
    return e.toString();
  }
}

putBidForAccept(String? bidId) async {
  final String bidApiUrl = FlutterConfig.get('biddingApiUrl');
  print('putBidUrl: $bidApiUrl/$bidId');

  Map<String, bool> data = {'shipperApproval': true};

  String body = json.encode(data);

  final response = await http.put(Uri.parse("$bidApiUrl/$bidId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body);

  print(response.body);
}

Future<String?> putBidForNegotiate(
    String? bidId, String? rate, String? unitValue) async {
  //TODO: This can be done in a better way later on
  if (unitValue == "RadioButtonOptions.PER_TON") {
    unitValue = "PER_TON";
  }
  if (unitValue == "RadioButtonOptions.PER_TRUCK") {
    unitValue = "PER_TRUCK";
  }
  try {
    final String bidApiUrl = FlutterConfig.get('biddingApiUrl');

    Map<String, dynamic> data = {
      "currentBid": rate,
      "unitValue": unitValue,
      'shipperApproval': true
    };

    String body = json.encode(data);

    final response = await http.put(Uri.parse("$bidApiUrl/$bidId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    if (response.statusCode == 200) {
      return "success";
    } else if (response.statusCode == 409) {
      return "conflict";
    }
    return "unsuccessful";
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}

declineBidFromShipperSide(String bidId) async {
  final String bidApiUrl = FlutterConfig.get('biddingApiUrl');

  Map<String, bool> data = {'transporterApproval': false};

  String body = json.encode(data);

  final response = await http.put(Uri.parse("$bidApiUrl/$bidId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body);

  print(response.body);
}

declineBidFromTransporterSideSide(
    {required String bidId, required approvalVariable}) async {
  final String bidApiUrl = FlutterConfig.get('biddingApiUrl');

  Map<String, bool> data = {'$approvalVariable': false};

  String body = json.encode(data);

  final response = await http.put(Uri.parse("$bidApiUrl/$bidId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body);

  print(response.body);
}
