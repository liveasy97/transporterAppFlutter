import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';

import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/constants/fontWeights.dart';


class NoInternet extends StatefulWidget {
  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,


          children: <Widget>[
            Image.asset('assets/images/wifi.gif', width: 115, height: 115,),
            SizedBox(
              height:3,
            ),
            Text(
              'Ooops!', style: TextStyle(fontWeight: mediumBoldWeight,
              fontFamily: 'Montserrat',
              fontSize: size_9,
              color: black,

            ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height:5,
            ),
            Text('Slow or no internet connection.\n Check your network connection and \n try again.', style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: normalWeight,
                fontSize: size_6,
                color:grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height:15,
            ),
            SizedBox(
              width: space_25 + 2 ,
              height: space_7 + 3,
              child: ElevatedButton(onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => super.widget));
              },
                child:   Text('Try Again',
                  style: TextStyle(color: black,
                      fontFamily: 'Montserrat',
                      fontWeight:mediumBoldWeight,
                      fontSize:size_6 + 1),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                    side: BorderSide(color: darkBlueColor),
                  )),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(statusBarColor),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
