import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/headingTextWidget.dart';
import 'package:liveasy/widgets/buttons/backButtonWidget.dart';
import 'package:liveasy/widgets/buttons/filterButton.dart';
import 'package:liveasy/widgets/suggestedLoadsWidget.dart';
import 'package:liveasy/widgets/loadDisplayCard.dart';

class SuggestedLoadScreen extends StatefulWidget {
  const SuggestedLoadScreen({Key? key}) : super(key: key);
  @override
  _SuggestedLoadScreenState createState() => _SuggestedLoadScreenState();
}

class _SuggestedLoadScreenState extends State<SuggestedLoadScreen> {
  var suggestedLoadData = SuggestedLoadsWidget.suggestedLoadData;
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.dark, statusBarColor: backgroundColor));
    return SafeArea(
        child: Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: space_4 - 1),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(width: space_4),
                  BackButtonWidget(),
                  SizedBox(width: space_3),
                  HeadingTextWidget("Suggested Loads"),
                  SizedBox(width: space_6),
                  FilterButtonWidget(),
                ]),
                SizedBox(
                  height: space_4 - 1,
                ),
                Container(
                  height: suggestedLoadData.length > 3
                      ? 655 //TODO: Height to be modified
                      : suggestedLoadData.length * 269,
                  color: backgroundColor,
                  padding: EdgeInsets.only(bottom: space_3 + 2),
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: space_4),
                      itemCount: suggestedLoadData.length > 3
                          ? 3
                          : suggestedLoadData.length,
                      itemBuilder: (BuildContext context, index) =>
                          LoadApiDataDisplayCard(
                            loadId: suggestedLoadData[index].loadId,
                            loadingPointState:
                                suggestedLoadData[index].loadingPointState,
                            loadingPointCity:
                                suggestedLoadData[index].loadingPointCity,
                            unloadingPointState:
                                suggestedLoadData[index].unloadingPointState,
                            unloadingPointCity:
                                suggestedLoadData[index].unloadingPointCity,
                            productType: suggestedLoadData[index].productType,
                            truckType: suggestedLoadData[index].truckType,
                            noOfTrucks: suggestedLoadData[index].noOfTrucks,
                            weight: suggestedLoadData[index].weight,
                            status: suggestedLoadData[index].status,
                            comment: suggestedLoadData[index].comment,
                            ordered: false,
                          )),
                ),
              ]),
            )));
  }
}
