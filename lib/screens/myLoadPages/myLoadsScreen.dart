import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/models/loadDetailsScreenModel.dart';
import 'package:liveasy/widgets/MyLoadsCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:liveasy/widgets/loadingWidgets/onGoingLoadingWidgets.dart';

class MyLoadsScreen extends StatefulWidget {
  @override
  _MyLoadsScreenState createState() => _MyLoadsScreenState();
}

class _MyLoadsScreenState extends State<MyLoadsScreen> {
  List<LoadDetailsScreenModel> myLoadList = [];

  final String loadApiUrl = FlutterConfig.get("loadApiUrl");

  ScrollController scrollController = ScrollController();

  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();

  int i = 0;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    getDataByPostLoadId(i);

    setState(() {
      loading = true;
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        i = i + 1;
        getDataByPostLoadId(i);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height -
            kBottomNavigationBarHeight -
            space_8,
        child: loading
            ? OnGoingLoadingWidgets()
            : myLoadList.length == 0
                ? Container(
                    margin: EdgeInsets.only(top: 153),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/EmptyLoad.png'),
                          height: 127,
                          width: 127,
                        ),
                        Text(
                          'Looks like you have not added any Loads!',
                          style: TextStyle(fontSize: size_8, color: grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: space_15),
                    controller: scrollController,
                    itemCount: myLoadList.length,
                    itemBuilder: (context, index) {
                      return MyLoadsCard(
                        loadDetailsScreenModel: myLoadList[index],
                      );
                    }));
  }

  getDataByPostLoadId(int i) async {
    http.Response response = await http.get(Uri.parse(
        '$loadApiUrl?postLoadId=${transporterIdController.transporterId.value}&pageNo=$i'));
    var jsonData = json.decode(response.body);
    for (var json in jsonData) {
      LoadDetailsScreenModel loadDetailsScreenModel = LoadDetailsScreenModel();
      loadDetailsScreenModel.loadId = json['loadId'];
      loadDetailsScreenModel.loadingPointCity =
          json['loadingPointCity'] != null ? json['loadingPointCity'] : 'NA';
      loadDetailsScreenModel.loadingPoint =
          json['loadingPoint'] != null ? json['loadingPoint'] : 'NA';
      loadDetailsScreenModel.loadingPointState =
          json['loadingPointState'] != null ? json['loadingPointState'] : 'NA';
      loadDetailsScreenModel.unloadingPointCity =
          json['unloadingPointCity'] != null
              ? json['unloadingPointCity']
              : 'NA';
      loadDetailsScreenModel.unloadingPoint =
          json['unloadingPoint'] != null ? json['unloadingPoint'] : 'NA';
      loadDetailsScreenModel.unloadingPointState =
          json['unloadingPointState'] != null
              ? json['unloadingPointState']
              : 'NA';
      loadDetailsScreenModel.postLoadId = json['postLoadId'];
      loadDetailsScreenModel.truckType =
          json['truckType'] != null ? json['truckType'] : 'NA';
      loadDetailsScreenModel.weight =
          json['weight'] != null ? json['weight'] : 'NA';
      loadDetailsScreenModel.productType =
          json['productType'] != null ? json['productType'] : 'NA';
      loadDetailsScreenModel.rate =
          json['rate'] != null ? json['rate'].toString() : 'NA';
      loadDetailsScreenModel.unitValue =
          json['unitValue'] != null ? json['unitValue'] : 'NA';
      loadDetailsScreenModel.noOfTrucks =
          json['noOfTrucks'] != null ? json['noOfTrucks'] : 'NA';
      loadDetailsScreenModel.loadDate =
          json['loadDate'] != null ? json['loadDate'] : 'NA';
      setState(() {
        myLoadList.add(loadDetailsScreenModel);
      });
    }
    setState(() {
      loading = false;
    });
  } //builder
} //class end
