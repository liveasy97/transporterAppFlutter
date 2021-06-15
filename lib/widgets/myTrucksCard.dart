import 'package:flutter/material.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/widgets/buttons/callButton.dart';
import 'package:liveasy/widgets/trackButton.dart';

// ignore: must_be_immutable
class MyTruckCard extends StatelessWidget {

  // TruckModel truckModel = TruckModel() ;

  String? truckId;
  String? transporterId;
  String? truckNo;
  bool truckApproved;
  String? imei;
  int? passingWeight;
  String? driverId;
  String? truckType;
  String?   tyres;

  MyTruckCard(
      {this.truckId,
        this.transporterId,
        this.truckNo,
        required this.truckApproved,
        this.imei,
        this.passingWeight,
        this.driverId,
        this.truckType,
        this.tyres});

  // MyTruckCard(truckModel);
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xffF7F8FA),
      margin: EdgeInsets.only(bottom: space_2),
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(space_3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, space_2, 0),
                    height: space_2,
                    width: space_2,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Text(
                      'Available',
                      style: TextStyle(
                        fontWeight: mediumBoldWeight,
                        fontSize: size_8),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: space_3 ),
                padding: EdgeInsets.only(right: space_8),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //number and type column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Vehicle Number',
                          style: TextStyle(
                              fontSize: size_6),
                        ),
                        Text(
                            '$truckNo',
                          style: TextStyle(
                            fontWeight: boldWeight,
                              fontSize: size_7),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: space_3),
                          child: Text(
                              'Truck Type',
                              style: TextStyle(
                              fontSize: size_6),),
                        ),
                        Text(
                            '$truckType',
                          style: TextStyle(
                              fontWeight: boldWeight,
                              fontSize: size_7),)
                      ],
                    ),
                    //tyre and driver column
                    Container(
                      // padding: EdgeInsets.only(left: space_14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tyre',
                            style: TextStyle(
                                fontSize: size_6),
                          ),
                          Text(
                            '$tyres',
                            style: TextStyle(
                                fontWeight: boldWeight,
                                fontSize: size_7),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: space_3),
                            child: Text(
                              'Driver',
                              style: TextStyle(
                                  fontSize: size_6),),
                          ),
                          Text(
                            'Ravi Shah',
                            style: TextStyle(
                                fontWeight: boldWeight,
                                fontSize: size_7),)
                        ],
                      ),
                    )
                  ],
                ),
              ),

              //track and call button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: space_2),
                      child: TrackButton(truckApproved:truckApproved)
                  ),
                  CallButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
