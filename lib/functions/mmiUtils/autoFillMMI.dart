import 'package:get/get.dart';
import 'package:liveasy/controller/tokenMMIController.dart';
import 'package:liveasy/functions/mmiUtils/tokenMMI.dart';
import 'package:liveasy/models/autoFillMMIModel.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

getMMIToken()async{
  TokenMMIController tokenMMIController = Get.find<TokenMMIController>();
  String token;
  if (tokenMMIController.tokenMMI.value == "") {
    token = await getMapMyIndiaToken();
  } else {
    token = tokenMMIController.tokenMMI.value;
  }
  print(token);
  return token;
}

Future<List<AutoFillMMIModel>> fillCityName(String cityName) async {
  if (cityName.length > 1) {
    // TokenMMIController tokenMMIController = Get.find<TokenMMIController>();
    // String token;
    // if (tokenMMIController.tokenMMI.value == "") {
    //   token = await getMapMyIndiaToken();
    // } else {
    //   token = tokenMMIController.tokenMMI.value;
    // }
    String token;
    token = await getMMIToken();

    Uri url = Uri.parse(
        "http://atlas.mapmyindia.com/api/places/search/json?query=$cityName&pod=CITY");
    http.Response response1 = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    print(response1.body);
    var address = (jsonDecode(response1.body));
    address = address["suggestedLocations"];
    print(address);
    List<AutoFillMMIModel> card = [];
    for (var json in address) {
      AutoFillMMIModel locationCardsModal = new AutoFillMMIModel(
          placeCityName: json["placeName"],
          placeStateName: json["placeAddress"]);
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
