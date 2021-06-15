import 'package:flutter/material.dart';
import 'package:liveasy/constants/borderWidth.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:get/get.dart';
import 'package:liveasy/functions/suggestedLoadsApi.dart';
import 'package:liveasy/widgets/bodyTextWidget.dart';
import 'package:liveasy/widgets/suggestedLoadDataDisplayCard.dart';
import 'package:liveasy/screens/suggestedLoadsScreen.dart';

// ignore: must_be_immutable
class SuggestedLoadsWidget extends StatelessWidget {
  static var suggestedLoadData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(space_2), color: darkBlueColor),
      child: Column(
        children: [
          Container(
            height: space_8,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  width: borderWidth_10,
                  color: lightGreyishBlueColor,
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: space_3), //28
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BodyTextWidget(
                      text: "Suggested Loads", color: greyishWhiteColor),
                  GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Get.to(() => SuggestedLoadScreen());
                      },
                      child: Text("See All",
                          style: TextStyle(color: liveasyGreenColor)))
                ],
              ),
            ),
          ),
          Container(
            child: FutureBuilder(
              future: runSuggestedLoadApi(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                      padding: EdgeInsets.only(top: 30),
                      child: CircularProgressIndicator(
                        color: white,
                      ));
                }
                suggestedLoadData = snapshot.data;
                return Container(
                  height: 106,
                  width: 309,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length >= 10
                          ? 10
                          : snapshot.data.length,
                      itemBuilder: (context, index) =>
                          SuggestedLoadDataDisplayCard(
                              loadingPointCity:
                                  snapshot.data[index].loadingPointCity,
                              unloadingPointCity:
                                  snapshot.data[index].unloadingPointCity,
                              onTap: () {})),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
