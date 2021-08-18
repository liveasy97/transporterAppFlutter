import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/textOverFlow.dart';
import 'package:liveasy/widgets/LoadEndPointTemplate.dart';
import 'package:get/get.dart';
import 'buttons/callButton.dart';
import 'buttons/completedButton.dart';
import 'buttons/trackButton.dart';
import 'linePainter.dart';
import 'loadLabelValueRowTemplate.dart';
import '../screens/shipperDetailsScreen.dart';

class OngoingCardOrders extends StatelessWidget {
  //variables
  final String loadingPoint;
  final String unloadingPoint;
  final String startedOn;
  final String endedOn;
  final String vehicleNo;
  final String companyName;
  final String driverPhoneNum;
  final String driverName;
  final String imei;
  final String transporterPhoneNumber;
  final String bookingId;
  final String rate;
  final String posterLocation;
  final bool companyApproved;
  final String posterName;
  final String truckType;
  final String noOfTrucks;
  final String productType;
  final String unitValue;

  // final String transporterName;

  OngoingCardOrders({
    required this.loadingPoint,
    required this.unloadingPoint,
    required this.startedOn,
    required this.endedOn,
    required this.vehicleNo,
    required this.companyName,
    required this.driverPhoneNum,
    required this.driverName,
    required this.imei,
    required this.bookingId,
    required this.transporterPhoneNumber,
    required this.rate,
    required this.companyApproved,
    required this.posterLocation,
    required this.posterName,
    required this.truckType,
    required this.noOfTrucks,
    required this.productType,
    required this.unitValue,

    // required this.transporterName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: space_3),
      child: Container(
        child: GestureDetector(
          onTap: () {
            Get.to(ShipperDetails(
              bookingId: bookingId,
              truckType: truckType,
              noOfTrucks: noOfTrucks,
              productType: productType,
              loadingPoint: loadingPoint,
              unloadingPoint: unloadingPoint,
              rate: rate,
              vehicleNo: vehicleNo,
              shipperPosterCompanyApproved: companyApproved,
              shipperPosterCompanyName: companyName,
              shipperPosterLocation: posterLocation,
              shipperPosterName: posterName,
              transporterPhoneNum: transporterPhoneNumber,
              driverPhoneNum: driverPhoneNum,
              driverName: driverName,
              transporterName: companyName,
              trackApproved: true,
            ));
          },
          child: Card(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(space_2),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LoadLabelValueRowTemplate(
                              value: startedOn, label: 'Booking date'),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                      SizedBox(
                        height: space_2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoadEndPointTemplate(
                              text: loadingPoint, endPointType: 'loading'),
                          Container(
                              padding: EdgeInsets.only(left: 2),
                              height: space_6,
                              width: space_12,
                              child: CustomPaint(
                                foregroundPainter: LinePainter(),
                              )),
                          LoadEndPointTemplate(
                              text: unloadingPoint, endPointType: 'unloading'),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: space_4),
                        child: Column(
                          children: [
                            LoadLabelValueRowTemplate(
                                value: vehicleNo, label: 'Truck no.'),
                            LoadLabelValueRowTemplate(
                                value: driverName, label: 'Driver Name'),
                            LoadLabelValueRowTemplate(
                                value: "Rs.$rate/$unitValue", label: 'Price'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: space_5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: space_1),
                                child: Image(
                                    height: 16,
                                    width: 23,
                                    color: black,
                                    image: AssetImage(
                                        'assets/icons/buildingIcon.png')),
                              ),
                              Text(
                                textOverflowEllipsis(companyName, 20),
                                style: TextStyle(
                                  color: liveasyBlackColor,
                                  fontWeight: mediumBoldWeight,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: space_2,
                          ),
                          CallButton(
                            directCall: false,
                            transporterPhoneNum: transporterPhoneNumber,
                            driverPhoneNum: driverPhoneNum,
                            driverName: driverName,
                            transporterName: companyName,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: contactPlaneBackground,
                  padding: EdgeInsets.symmetric(
                    vertical: space_2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TrackButton(truckApproved: false),
                      CompletedButtonOrders(
                          bookingId: bookingId, fontSize: size_7),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
