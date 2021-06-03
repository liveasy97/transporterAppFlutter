import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/getsCardDataFunction.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/widgets/availableLoadsTextWidget.dart';
import 'package:liveasy/widgets/cancelIconWidget.dart';
import 'package:liveasy/widgets/filterButtonWidget.dart';
import 'package:liveasy/widgets/headingTextWidget.dart';
import 'package:liveasy/widgets/helpButtonWidget.dart';
import 'package:liveasy/widgets/loadingPointImageIcon.dart';
import 'package:liveasy/widgets/loadingWidget.dart';
import 'package:liveasy/widgets/unloadingPointImageIcon.dart';
import 'package:provider/provider.dart';
import 'package:liveasy/widgets/addressInputWidget.dart';
import 'package:liveasy/widgets/backButtonWidget.dart';

import '../loadScreenCardsModal.dart';
import '../detailCard.dart';

class FindLoadScreen extends StatefulWidget {
  @override
  _FindLoadScreenState createState() => _FindLoadScreenState();
}

class _FindLoadScreenState extends State<FindLoadScreen> {

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ProviderData>(context).loadingPointCity != "") {
      controller1 = TextEditingController(
          text:
          ("${Provider.of<ProviderData>(context, listen: false).loadingPointCity} (${Provider.of<ProviderData>(context, listen: false).loadingPointState})"));
    }
    if (Provider.of<ProviderData>(context).unloadingPointCity != "") {
      controller2 = TextEditingController(
          text:
          ("${Provider.of<ProviderData>(context, listen: false).unloadingPointCity} (${Provider.of<ProviderData>(context, listen: false).unloadingPointState})"));
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: space_4),
              child: Column(children: [
                SizedBox(
                  height: space_8,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BackButtonWidget(),
                          SizedBox(
                            width: space_3,
                          ),
                          HeadingTextWidget("Find Load"),
                          // HelpButtonWidget(),
                        ],
                      ),
                      HelpButtonWidget(),
                    ],
                  ),
                ),
                SizedBox(
                  height: space_5,
                ),
                AddressInputWidget(
                  hintText: "Loading Point",
                  icon: LoadingPointImageIcon(
                    height: 12,
                    width: 12,
                  ),
                  controller: controller1,
                  clearIcon: IconButton(
                    onPressed: () {
                      Provider.of<ProviderData>(context, listen: false)
                          .clearLoadingPoint();
                    },
                    icon: CancelIconWidget(),
                  ),
                ),
                SizedBox(
                  height: space_4,
                ),
                AddressInputWidget(
                  hintText: "Unloading Point",
                  icon: UnloadingPointImageIcon(
                    height: 12,
                    width: 12,
                  ),
                  controller: controller2,
                  clearIcon: IconButton(
                    onPressed: () {
                      Provider.of<ProviderData>(context, listen: false)
                          .clearUnloadingPoint();
                    },
                    icon: CancelIconWidget(),
                  ),
                ),
                SizedBox(
                  height: space_3,
                ),
              ]),
            ),
            Container(
              color: solidLineColor,
              height: 1,
            ),
            SizedBox(
              height: space_4 - 1,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: space_4),
              child: FutureBuilder(
                      future: getCardsData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return LoadingWidget();
                        }
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AvailableLoadsTextWidget(),
                                /*FilterButtonWidget()*/
                              ],
                            ),
                            SizedBox(
                              height: space_4-1,
                            ),
                            Container(
                              height: 430, //TODO to be modified
                              //alternative-(MediaQuery.of(context).size.height-(previous height))
                              child: ListView.builder(
                                reverse: false,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                ),
                                itemCount: (snapshot.data.length),
                                itemBuilder: (BuildContext context, index) => DetailCard(
                                  loadingPoint: snapshot.data[index].loadingPoint,
                                  unloadingPoint: snapshot.data[index].unloadingPoint,
                                  productType: snapshot.data[index].productType,
                                  truckType: snapshot.data[index].truckType,
                                  noOfTrucks: snapshot.data[index].noOfTrucks,
                                  weight: snapshot.data[index].weight,
                                  isPending: snapshot.data[index].status == 'pending'
                                      ? true
                                      : false,
                                  comment: snapshot.data[index].comment,
                                  isCommentsEmpty:
                                  snapshot.data[index].comment == '' ? true : false,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
              ),
          ],
        ),
      ),
    );
  }
}