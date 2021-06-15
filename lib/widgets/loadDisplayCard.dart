import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/elevation.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/screens/loadDetailsScreen.dart';
import 'package:liveasy/widgets/alertDialog/verifyAccountNotifyAlertDialog.dart';
import 'package:liveasy/widgets/buttons/bidButton.dart';
import 'package:liveasy/widgets/buttons/viewBiddingsButton.dart';
import 'package:liveasy/widgets/contactWidget.dart';
import 'package:liveasy/widgets/loadingPointImageIcon.dart';
import 'package:liveasy/widgets/linePainter.dart';
import 'package:liveasy/widgets/buttons/priceButton.dart';
import 'package:liveasy/widgets/truckImageWidget.dart';
import 'package:liveasy/widgets/unloadingPointImageIcon.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoadApiDataDisplayCard extends StatelessWidget {
  String? loadId;
  String? loadingPoint;
  String? loadingPointCity;
  String? loadingPointState;
  String? id;
  String? unloadingPoint;
  String? unloadingPointCity;
  String? unloadingPointState;
  String? productType;
  String? truckType;
  String? noOfTrucks;
  String? weight;
  String? comment;
  String? status;
  String? date;
  bool? ordered;

  LoadApiDataDisplayCard(
      {this.loadId,
      this.loadingPoint,
      this.loadingPointCity,
      this.loadingPointState,
      this.id,
      this.unloadingPoint,
      this.unloadingPointCity,
      this.unloadingPointState,
      this.productType,
      this.truckType,
      this.noOfTrucks,
      this.weight,
      this.comment,
      this.status,
      this.date,
      this.ordered});

  TransporterIdController tIdController = Get.find<TransporterIdController>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          // ignore: unrelated_type_equality_checks
          if (tIdController.transporterApproved == false) {
            Get.to(() => LoadDetailsScreen(
                loadId: "$loadId",
                loadingPoint: "$loadingPoint",
                loadingPointCity: "$loadingPointCity",
                loadingPointState: "$loadingPointState",
                unloadingPoint: "$unloadingPoint",
                unloadingPointCity: "$unloadingPointCity",
                unloadingPointState: "$unloadingPointState",
                productType: "$productType",
                truckType: "$truckType",
                noOfTrucks: "$noOfTrucks",
                weight: "$weight",
                comment: "$comment",
                status: "$status",
                date: "$comment"));
          } else {
            VerifyAccountNotifyAlertDialog(context);
          }
        },
        child: Card(
          elevation: elevation_2,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: space_3, top: space_3 - 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                LoadingPointImageIcon(
                                  height: 8.96,
                                  width: space_2,
                                ),
                                SizedBox(
                                  width: space_2 - 1,
                                ),
                                Expanded(
                                  child: Text(
                                    "$loadingPointCity",
                                    style: TextStyle(
                                        fontSize: size_9,
                                        color: loadScreenPrimaryTextColor,
                                        fontWeight: mediumBoldWeight),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                height: 28.08,
                                padding: EdgeInsets.only(left: space_1 - 3),
                                child: CustomPaint(
                                  foregroundPainter: LinePainter(),
                                )),
                            Row(
                              children: [
                                UnloadingPointImageIcon(
                                    width: space_2, height: 8.96),
                                SizedBox(
                                  width: space_2 - 1,
                                ),
                                Expanded(
                                  child: Text(
                                    "$unloadingPointCity",
                                    style: TextStyle(
                                        fontSize: size_9,
                                        color: loadScreenPrimaryTextColor,
                                        fontWeight: mediumBoldWeight),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: space_1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Column(
                                            children: [
                                              Text("Truck Type",
                                                  style: TextStyle(
                                                      fontSize: size_6 - 1,
                                                      fontWeight: regularWeight,
                                                      color:
                                                          loadScreenSecondaryTextColor)),
                                              Text("$truckType",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          mediumBoldWeight,
                                                      fontSize: size_7,
                                                      color:
                                                          loadScreenPrimaryTextColor))
                                            ],
                                          ),
                                          SizedBox(
                                            height: space_2 + 3,
                                          ),
                                          Column(
                                            children: [
                                              Text("Weight",
                                                  style: TextStyle(
                                                      fontSize: size_6 - 1,
                                                      fontWeight: regularWeight,
                                                      color:
                                                          loadScreenSecondaryTextColor)),
                                              Text("$weight",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          mediumBoldWeight,
                                                      fontSize: size_7,
                                                      color:
                                                          loadScreenPrimaryTextColor))
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Text("Tyre",
                                                style: TextStyle(
                                                    fontSize: size_6 - 1,
                                                    fontWeight: regularWeight,
                                                    color:
                                                        loadScreenSecondaryTextColor)),
                                            Text("NA",
                                                style: TextStyle(
                                                  fontWeight: mediumBoldWeight,
                                                  fontSize: size_7,
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: space_2,
                                        ),
                                        Column(
                                          children: [
                                            Text("Product type",
                                                style: TextStyle(
                                                    fontSize: size_6 - 1,
                                                    fontWeight: regularWeight,
                                                    color:
                                                        loadScreenSecondaryTextColor)),
                                            Container(
                                              child: Text("$productType",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          mediumBoldWeight,
                                                      fontSize: size_7,
                                                      color:
                                                          loadScreenPrimaryTextColor)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Container(
                      padding:
                          EdgeInsets.only(top: space_3 - 1, right: space_2 - 2),
                      child: TruckImageWidget())
                ],
              ),
              SizedBox(
                height: space_3 - 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceButtonWidget(),
                  ordered == true ? ViewBidsButton() : BidButton("$loadId"),
                ],
              ),
              SizedBox(
                height: space_2,
              ),
              ordered == true ? Container() : ContactWidget()
            ],
          ),
        ),
      ),
      SizedBox(height: space_3)
    ]);
  }
}
