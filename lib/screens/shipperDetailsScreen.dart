import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/textOverFlow.dart';
import 'package:liveasy/widgets/buttons/backButtonWidget.dart';
import 'package:liveasy/widgets/buttons/callButton.dart';
import 'package:liveasy/widgets/buttons/completedButton.dart';
import 'package:liveasy/widgets/buttons/trackButton.dart';
import 'package:liveasy/widgets/headingTextWidget.dart';
import 'package:liveasy/widgets/loadLabelValueRowTemplate.dart';
import 'package:liveasy/widgets/shipperPosterDetails.dart';

class ShipperDetails extends StatefulWidget {
  String? loadingPoint;
  String? unloadingPoint;
  String? vehicleNo;
  String? rate;
  String? shipperPosterLocation;
  String? shipperPosterName;
  String? shipperPosterCompanyName;
  bool? shipperPosterCompanyApproved;
  String? posterName;
  String? truckType;
  String? noOfTrucks;
  String? productType;
  String bookingId;
  String? transporterPhoneNum;
  String? driverPhoneNum;
  String? driverName;
  String? transporterName;
  bool? trackApproved;

  ShipperDetails(
      {Key? key,
      this.posterName,
      this.truckType,
      this.noOfTrucks,
      this.productType,
      this.loadingPoint,
      this.unloadingPoint,
      this.vehicleNo,
      this.rate,
      this.shipperPosterLocation,
      this.shipperPosterName,
      this.shipperPosterCompanyName,
      this.shipperPosterCompanyApproved,
      required this.bookingId,
      this.transporterPhoneNum,
      this.driverPhoneNum,
      this.driverName,
      this.transporterName,
      this.trackApproved})
      : super(key: key);

  @override
  _ShipperDetailsState createState() => _ShipperDetailsState();
}

class _ShipperDetailsState extends State<ShipperDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: space_2),
          child: Column(
            children: [
              SizedBox(
                height: space_4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButtonWidget(),
                  SizedBox(
                    width: space_3,
                  ),
                  HeadingTextWidget("Order Details"),
                  // HelpButtonWidget(),
                ],
              ),
              SizedBox(
                height: space_3,
              ),
              Stack(
                children: [
                  ShipperPosterDetails(
                    shipperPosterCompanyApproved:
                        widget.shipperPosterCompanyApproved,
                    shipperPosterName: widget.shipperPosterName,
                    shipperPosterLocation: widget.shipperPosterLocation,
                    shipperPosterCompanyName: widget.shipperPosterCompanyName,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: space_8,
                        top: MediaQuery.of(context).size.height * 0.192,
                        right: space_8),
                    child: Container(
                      height: space_10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius_2 - 2)),
                      child: Card(
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TrackButton(truckApproved: widget.trackApproved!),
                            CallButton(
                              directCall: false,
                              transporterPhoneNum: widget.transporterPhoneNum,
                              driverPhoneNum: widget.driverPhoneNum,
                              driverName: widget.driverName,
                              transporterName: widget.transporterName,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: space_5,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(space_3, space_2, space_3, space_3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LoadLabelValueRowTemplate(
                          value: textOverflowEllipsis(
                              "${widget.loadingPoint}-${widget.unloadingPoint}",20
                          ),
                          label: 'Location'),
                      LoadLabelValueRowTemplate(
                          value: widget.vehicleNo, label: 'Truck no.'),
                      LoadLabelValueRowTemplate(
                          value: widget.truckType, label: 'Truck Type'),
                      LoadLabelValueRowTemplate(
                          value: widget.noOfTrucks, label: 'No.Of Trucks'),
                      LoadLabelValueRowTemplate(
                          value: widget.productType, label: 'Product Type'),
                      LoadLabelValueRowTemplate(
                          value: "Rs.${widget.rate}/tonne", label: 'Price'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: space_2,
              ),
              widget.trackApproved == false ? Container()
                  :CompletedButtonOrders(
                bookingId: widget.bookingId,
                fontSize: size_9,
              )
            ],
          ),
        ),
      ),
    );
  }
}
