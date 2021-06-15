import 'package:get/get.dart';
import 'package:liveasy/controller/tokenMMIController.dart';
import 'package:liveasy/functions/tokenMMI.dart';
import 'package:liveasy/models/autoFillMMIModel.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


Future<List<AutoFillMMIModel>> fillCityName(String cityName) async {
  if (cityName.length > 1) {
    TokenMMIController tokenMMIController = Get.find<TokenMMIController>();
    String token;
    if (tokenMMIController.tokenMMI.value == "") {
      token = await getMapMyIndiaToken();
    } else {
      token = tokenMMIController.tokenMMI.value;
    }

    await http.get(Uri.parse('http://52.53.40.46:8080/load'));
    Uri url = Uri(
        scheme: 'http',
        host: "atlas.mapmyindia.com",
        path: "api/places/search/json?query=$cityName&pod=CITY");
    http.Response response1 = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    var adress = (jsonDecode(response1.body));
    adress = adress["suggestedLocations"];
    print(adress);
    List<AutoFillMMIModel> card = [];
    for (var json in adress) {
      AutoFillMMIModel locationCardsModal =
      new AutoFillMMIModel(placeCityName: json["placeName"],placeStateName: json["placeAddress"]);
      card.add(locationCardsModal);
    }
    // card = card
    //   ..sort(
    //           (a, b) => a.placeCityName.toString().compareTo(b.placeStateName.toString()));
    return card;
  } else {
    List<AutoFillMMIModel> card = [];
    return card;
  }
}
