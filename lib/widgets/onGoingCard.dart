import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/buttons/trackButton.dart';
import 'package:liveasy/screens/myLoadPages/onGoingLoadDetails.dart';
import 'package:liveasy/widgets/LoadEndPointTemplate.dart';
import 'package:liveasy/widgets/buttons/callButton.dart';
import 'package:liveasy/widgets/newRowTemplate.dart';
import 'linePainter.dart';

class OngoingCard extends StatelessWidget {

  Map loadAllDataModel;


  OngoingCard({
    required this.loadAllDataModel,
  });

  @override
  Widget build(BuildContext context) {

    loadAllDataModel['driverName'] = loadAllDataModel['driverName'].length >= 20
        ? loadAllDataModel['driverName'].substring(0, 18) + '..'
        : loadAllDataModel['driverName'];

    loadAllDataModel['companyName'] = loadAllDataModel['companyName'].length >= 35
        ? loadAllDataModel['companyName'].substring(0, 33) + '..'
        : loadAllDataModel['companyName'];

    loadAllDataModel['unitValue'] = loadAllDataModel['unitValue'] == "PER_TON" ? 'tonne' : 'truck';



    return GestureDetector(
      onTap: (){
        Get.to(() => OnGoingLoadDetails(loadALlDataModel: loadAllDataModel,trackIndicator: false,));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: space_3),
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(space_4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Booking Date : ${loadAllDataModel['bookingDate']}',
                          style: TextStyle(
                            fontSize: size_6,
                            color: veryDarkGrey,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoadEndPointTemplate(
                            text: loadAllDataModel['loadingPoint'], endPointType: 'loading'),
                        Container(
                            padding: EdgeInsets.only(left: 2),
                            height: space_3,
                            width: space_12,
                            child: CustomPaint(
                              foregroundPainter: LinePainter(
                                height: space_3
                              ),
                            )),
                        LoadEndPointTemplate(
                            text: loadAllDataModel['unloadingPoint'], endPointType: 'unloading'),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: space_4),
                      child: Column(
                        children: [
                          NewRowTemplate(label: 'Truck No', value: loadAllDataModel['truckNo'] , width: 78,),
                          NewRowTemplate(label: 'Driver Name', value: loadAllDataModel['driverName']),
                          NewRowTemplate(label: 'Price', value: '${loadAllDataModel['rate']}/${loadAllDataModel['unitValue']}' , width: 78,),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: space_4),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: space_1),
                            child: Image(
                                height: 16,
                                width: 23,
                                color: black,
                                image:
                                AssetImage('assets/icons/TruckIcon.png')),
                          ),
                          Text(
                            loadAllDataModel['companyName'],
                            style: TextStyle(
                              color: liveasyBlackColor,
                              fontWeight: mediumBoldWeight,
                            ),
                          )
                        ],
                      ),
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
                    CallButton(
                      directCall: false,
                      transporterPhoneNum: loadAllDataModel['transporterPhoneNum'],
                      driverPhoneNum: loadAllDataModel['driverPhoneNum'],
                      driverName: loadAllDataModel['driverName'],
                      transporterName: loadAllDataModel['companyName'],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
