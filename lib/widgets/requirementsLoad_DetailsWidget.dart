import 'package:flutter/material.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

class RequirementsLoadDetails extends StatelessWidget {
  String? truckType, tyre, weight, productType;
  RequirementsLoadDetails(this.truckType,this.tyre,this.weight,this.productType);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Requirements",
          style: TextStyle(
              fontWeight: mediumBoldWeight, fontSize: size_7),
        ),
        Container(
          padding: EdgeInsets.only(left: space_3, right: space_3,top: space_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Truck Type",
                    style: TextStyle(
                        fontWeight: regularWeight,
                        fontSize: size_7),
                  ),

                  Text(
                      "$truckType",
                      style: TextStyle(
                          fontWeight: normalWeight,
                          fontSize: size_7),)
                ],
              ),
              SizedBox(
                height: space_1 + 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tyre",
                    style: TextStyle(
                        fontWeight: regularWeight,
                        fontSize: size_7),
                  ),
                  Text(
                    "null",
                    style: TextStyle(
                        fontWeight: normalWeight,
                        fontSize: size_7),
                  )
                ],
              ),
              SizedBox(
                height: space_1 + 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Weight",
                    style: TextStyle(
                        fontWeight: regularWeight,
                        fontSize: size_7),
                  ),
                  Text(
                    "$weight",
                    style: TextStyle(
                        fontWeight: normalWeight,
                        fontSize: size_7),
                  )
                ],
              ),
              SizedBox(
                height: space_1 + 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Product Type",
                    style: TextStyle(
                        fontWeight: regularWeight,
                        fontSize: size_7),
                  ),
                  Text(
                    "$productType",
                    style: TextStyle(
                        fontWeight: normalWeight,
                        fontSize: size_7),
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
