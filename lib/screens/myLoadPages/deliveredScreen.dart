import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/loadOnGoingDeliveredData.dart';
import 'package:liveasy/models/BookingModel.dart';
import 'package:liveasy/widgets/deliveredCard.dart';
import 'package:liveasy/widgets/loadingWidget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:liveasy/widgets/loadingWidgets/completedLoadingWidgets.dart';

class DeliveredScreen extends StatefulWidget {
  @override
  _DeliveredScreenState createState() => _DeliveredScreenState();
}

class _DeliveredScreenState extends State<DeliveredScreen> {
  //for counting page numbers
  int i = 0;

  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();

  final String bookingApiUrl = FlutterConfig.get('bookingApiUrl');

  List<BookingModel> modelList = [];

  ScrollController scrollController = ScrollController();

  getDataByPostLoadIdDelivered(int i) async {
    // modelList = [];
    http.Response response = await http.get(Uri.parse(
        '$bookingApiUrl?postLoadId=${transporterIdController.transporterId.value}&completed=true&cancel=false&pageNo=$i'));

    var jsonData = json.decode(response.body);

    for (var json in jsonData) {
      BookingModel bookingModel = BookingModel(truckId: []);
      bookingModel.bookingDate =
          json['bookingDate'] != null ? json['bookingDate'] : "NA";
      bookingModel.bookingId = json['bookingId'];
      bookingModel.postLoadId = json['postLoadId'];
      bookingModel.loadId = json['loadId'];
      bookingModel.transporterId = json['transporterId'];
      bookingModel.truckId = json['truckId'];
      bookingModel.cancel = json['cancel'];
      bookingModel.completed = json['completed'];
      bookingModel.completedDate =
          json['completedDate'] != null ? json['completedDate'] : "NA";
      bookingModel.rate = json['rate'] != null ? json['rate'] : 'NA';
      bookingModel.unitValue = json['unitValue'];

      setState(() {
        modelList.add(bookingModel);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getDataByPostLoadIdDelivered(i);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        i = i + 1;
        getDataByPostLoadIdDelivered(i);
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
        child: modelList.length == 0
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
                itemCount: modelList.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      future: loadAllData(modelList[index]),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return CompletedLoadingWidgets();
                        }
                        return DeliveredCard(
                          model: snapshot.data,
                        );
                      });
                } //builder

                ));
  }
} //class end
