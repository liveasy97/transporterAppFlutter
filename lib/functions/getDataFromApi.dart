import 'package:http/http.dart' as http;
import 'package:liveasy/models/truckModel.dart';
import 'dart:convert';

class GetDataFromApi{

  var jsonData;
  List<TruckModel> truckDataList = [];

  Future<List<TruckModel>> getTruckData() async {
    http.Response response = await http.get(Uri.parse("http://ec2-65-2-131-164.ap-south-1.compute.amazonaws.com:9090/truck"));
    jsonData = json.decode(response.body);

    for (var json in jsonData) {
      TruckModel truckModel = TruckModel( truckApproved: false);
      truckModel.truckId = json["truckId"];
      truckModel.transporterId = json["transporterId"];
      truckModel.truckNo = json["truckNo"];
      truckModel.truckApproved = json["truckApproved"];
      truckModel.imei = json["imei"];
      truckModel.passingWeight = json["passingWeight"];
      truckModel.truckType = json["truckType"];
      truckModel.driverId = json["driverId"];
      truckModel.tyres = json["tyres"];
      truckDataList.add(truckModel);
    }
    return truckDataList;
  }
}