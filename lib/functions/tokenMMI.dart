import 'package:get/get.dart';
import 'package:liveasy/controller/tokenMMIController.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

Future<String> getMapMyIndiaToken() async {
  String clientIdMapMyIndia = FlutterConfig.get("clientIdMapMyIndia").toString();
  String clientSecretMapMyIndia = FlutterConfig.get("clientSecretMapMyIndia").toString();
  TokenMMIController tokenMMIController = Get.find<TokenMMIController>();
  Uri tokenUrl = Uri(
      scheme: "https",
      host: "outpost.mapmyindia.com",
      path: 'api/security/oauth/token',
      queryParameters: {
        "grant_type": "client_credentials",
        "client_id": "$clientIdMapMyIndia",
        "client_secret": "$clientSecretMapMyIndia"
      });
  http.Response tokenGet = await http.post(tokenUrl);
  var body = jsonDecode(tokenGet.body);
  var token = body["access_token"];
  print("token = $token");
  tokenMMIController.updateTokenMMI(token);
  return token;
}