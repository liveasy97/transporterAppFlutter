import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/controller/truckIdController.dart';
import 'package:liveasy/models/truckModel.dart';
import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';

class TruckApiCalls {
  // retrieving TRUCKAPIURL  from env file
  final String truckApiUrl = FlutterConfig.get('truckApiUrl');

  // transporterId controller
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();

  //truckId controller ..used to store truckId for latest truck
  TruckIdController truckIdController = TruckIdController();

  //json data list
  late List jsonData;

  // Truck Model List used to  create cards
  List<TruckModel> truckDataList = [];

  // This variable is used to return truckId to MyTruckScreens
  String? _truckId;

//GET---------------------------------------------------------------------------

  Future<List<TruckModel>> getTruckData() async {
    for (int i = 0;; i++) {
      http.Response response = await http.get(Uri.parse(truckApiUrl +
          '?transporterId=${transporterIdController.transporterId.value}&pageNo=$i'));
      jsonData = json.decode(response.body);
      if (jsonData.isEmpty) {
        break;
      }

      for (var json in jsonData) {
        TruckModel truckModel = TruckModel(truckApproved: false);
        truckModel.truckId = json["truckId"];
        truckModel.transporterId = json["transporterId"];
        truckModel.truckNo = json["truckNo"];
        truckModel.truckApproved = json["truckApproved"];
        truckModel.imei = json["imei"];
        truckModel.passingWeight = json["passingWeight"];
        truckModel.truckType = json["truckType"];
        truckModel.driverId = json["driverId"];
        truckModel.tyres = json["tyres"].toString();
        truckDataList.add(truckModel);
      }
    }
    return truckDataList; // list of truckModels
  }

  //GET Truck Data by truckId
  Future<Map> getDataByTruckId(String truckId) async {
    http.Response response = await http.get(Uri.parse('$truckApiUrl/$truckId'));
    var jsonData = json.decode(response.body);

    Map data = {
      'driverId': jsonData['driverId'] != null ? jsonData['driverId'] : 'NA',
      'truckNo': jsonData['truckNo'] != null ? jsonData['truckNo'] : 'NA',
      'imei': jsonData['imei'] != null ? jsonData['imei'] : 'NA',
      'truckType': jsonData['truckType'] != null ? jsonData['truckType'] : 'NA',
    };

    return data;
  }

  //POST------------------------------------------------------------------------
  Future<String?> postTruckData({required String truckNo}) async {
    // json map
    Map<String, dynamic> data = {
      "transporterId": transporterIdController.transporterId.value,
      "truckNo": truckNo,
    };

    String body = json.encode(data);

    //post request
    http.Response response = await http.post(Uri.parse(truckApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    var returnData = json.decode(response.body);

    _truckId = returnData['truckId'];

    return _truckId;
  } //post truck data

  //PUT-------------------------------------------------------------------------

  Future<String?> putTruckData(
      {required String truckID,
      required String truckType,
      required int totalTyres,
      required int passingWeight,
      required int truckLength,
      required String driverID}) async {
    //json map
    Map<String, dynamic> data = {
      "driverId": driverID == '' ? null : driverID,
      "imei": null,
      "passingWeight": passingWeight == 0 ? null : passingWeight,
      "transporterId": transporterIdController.transporterId.value,
      "truckApproved": false,
      "truckType": truckType == '' ? null : truckType,
      "truckLength": truckLength == 0 ? null : truckLength,
      "tyres": totalTyres == 0 ? null : totalTyres
    };

    String body = json.encode(data);

    http.Response response = await http.put(Uri.parse('$truckApiUrl/$truckID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    var returnData = json.decode(response.body);
    _truckId = returnData['truckId'];
    return _truckId;
  }

  updateDriverIdForTruck(
      {required String truckID, required String driverID}) async {
    //json map
    Map<String, dynamic> data = {
      "driverId": driverID == '' ? null : driverID,
    };

    String body = json.encode(data);

    http.Response response = await http.put(Uri.parse('$truckApiUrl/$truckID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    var returnData = json.decode(response.body);
    _truckId = returnData['truckId'];
  }
} //class end
