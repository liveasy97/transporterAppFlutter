import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/screens/myLoadPages/onGoingLoadDetails.dart';
import 'package:liveasy/widgets/LoadEndPointTemplate.dart';
import 'package:liveasy/widgets/loadLabelValueRowTemplate.dart';
import 'package:liveasy/widgets/newRowTemplate.dart';
import 'package:get/get.dart';
import 'linePainter.dart';

class DeliveredCard extends StatelessWidget {
  Map model;


  DeliveredCard({
    required this.model

  });

  @override
  Widget build(BuildContext context) {

    model['companyName'] = model['companyName'].length >= 35
        ? model['companyName'].substring(0, 33) + '..'
        : model['companyName'];

    model['unitValue'] = model['unitValue'] == 'PER_TON' ? 'tonne' : 'truck' ;
    return GestureDetector(
      onTap: (){
        Get.to(() => OnGoingLoadDetails(loadALlDataModel: model,trackIndicator: false,));
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
                          'Completed Date : ${model['completedDate']}',
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
                    SizedBox(height: space_1,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoadEndPointTemplate(
                            text: model['loadingPoint'], endPointType: 'loading'),
                        Container(
                            padding: EdgeInsets.only(left: 2),
                            height: space_3,
                            width: space_12,
                            child: CustomPaint(
                              foregroundPainter: LinePainter(height:  space_3),
                            )),
                        LoadEndPointTemplate(
                            text: model['unloadingPoint'], endPointType: 'unloading'),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: space_2),
                      child: Column(
                        children: [
                            NewRowTemplate(label: 'Booking Date', value: model['bookingDate']),
                            NewRowTemplate(label: 'Price', value: '${model['rate']}/${model['unitValue']}' , width: 100,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // color: contactPlaneBackground,
                padding:
                    EdgeInsets.fromLTRB(space_3, 0, space_3, space_3),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: space_1),
                      child: Image(
                          height: 16,
                          width: 23,
                          color: black,
                          image: AssetImage('assets/icons/buildingIconBlack.png')),
                    ),
                    Text(
                      model['companyName'],
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
      ),
    );
  }
}
