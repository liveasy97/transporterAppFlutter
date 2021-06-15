import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';

// ignore: must_be_immutable
class TrackButton extends StatelessWidget {

  bool truckApproved = false;

  TrackButton({ required this.truckApproved});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      width: 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(darkBlueColor),
        ),
        onPressed: (){print('Track Button Pressed');},
        child: Row(
          children: [
            // if(truckApproved == false){
            //
            // },
            Container(
              child: truckApproved ? Container() : Icon(
                Icons.lock,
                size: 18 ,
                color: truckGreen,
              ),
            ),


            Text(
              'Track',
              style: TextStyle(
                letterSpacing: 0.7,
                fontWeight: FontWeight.w400,
                color: white,
                fontSize: space_3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
