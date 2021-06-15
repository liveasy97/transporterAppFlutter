import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:liveasy/models/suggestedLoadApiModel.dart';
import 'package:flutter_config/flutter_config.dart';

Future<List<SuggestLoadApiDataModel>> runSuggestedLoadApi() async {
  String loadApiUrl = FlutterConfig.get("loadApiUrl").toString();
  var jsonData;
  Uri url = Uri.parse("$loadApiUrl");
  http.Response response = await http.get(url);
  jsonData = await jsonDecode(response.body);
  List<SuggestLoadApiDataModel> data = [];
  for (var json in jsonData) {
    SuggestLoadApiDataModel loadData = new SuggestLoadApiDataModel(
        loadId: "",
        loadingPointCity: json["loadingPointCity"],
        loadingPointState: "",
        unloadingPointCity: json["unloadingPointCity"],
        truckType: json["truckType"],
        noOfTrucks: "",
        status: "",
        unloadingPointState: "",
        weight: json["weight"],
        productType: json["productType"],
        comment: "");
    data.add(loadData);
  }
  return data;
}
