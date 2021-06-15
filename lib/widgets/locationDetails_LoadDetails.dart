import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

// ignore: must_be_immutable
class LocationDetailsLoadDetails extends StatelessWidget {
  String? loadingPoint;
  String? loadingPointCity;
  String? loadingPointState;
  String? unloadingPoint;
  String? unloadingPointCity;
  String? unloadingPointState;

  LocationDetailsLoadDetails(
  {this.loadingPoint,
    this.loadingPointCity,
    this.loadingPointState,
    this.unloadingPoint,
    this.unloadingPointCity,
    this.unloadingPointState,});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Location Details",
          style: TextStyle(
              fontWeight: mediumBoldWeight, fontSize: size_7),
        ),
        Container(
          padding: EdgeInsets.only(left: space_3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: space_2,
              ),
              Row(
                children: [
                  Container(
                    child: Image(
                      image: AssetImage(
                          "assets/icons/greenFilledCircleIcon.png"),
                    ),
                    width: space_2,
                    height: space_2,
                  ),
                  SizedBox(
                    width: space_1,
                  ),
                  Text(
                    "$loadingPoint,$loadingPointCity,$loadingPointState",
                    style: TextStyle(
                        fontWeight: normalWeight,
                        fontSize: size_6),
                  )
                ],
              ),
              Container(
                height: space_4+3,
                color: locationLineColor,
                width: 1,
                padding: EdgeInsets.only(left: space_7 + 4),
              ),
              Row(
                children: [
                  Container(
                    child: Image(
                      image: AssetImage(
                          "assets/icons/redSemiFilledCircleIcon.png"),
                    ),
                    width: space_2,
                    height: space_2,
                  ),
                  SizedBox(
                    width: space_1,
                  ),
                  Text(
                    "$unloadingPoint,$unloadingPointCity,$unloadingPointState",
                    style: TextStyle(
                        fontWeight: normalWeight,
                        fontSize: size_6),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
