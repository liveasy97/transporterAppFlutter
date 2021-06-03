import 'dart:convert';
import 'package:http/http.dart' as http;
import '../loadScreenCardsModal.dart';
var jsonData;
List<LoadScreenCardsModal> card = [];
Future<List<LoadScreenCardsModal>> getCardsData() async {
  http.Response response = await http.get(Uri.parse("http://52.53.40.46:8080/load"));
  jsonData = json.decode(response.body);

  for (var json in jsonData) {
    LoadScreenCardsModal cardsModal = LoadScreenCardsModal();
    cardsModal.loadingPoint = json["loadingPoint"];
    cardsModal.unloadingPoint = json["unloadingPoint"];
    cardsModal.productType = json["productType"];
    cardsModal.truckType = json["truckType"];
    cardsModal.noOfTrucks = json["noOfTrucks"];
    cardsModal.weight = json["weight"];
    cardsModal.comment = json["comment"];
    cardsModal.status = json["status"];
    card.add(cardsModal);
  }
  return card;
}