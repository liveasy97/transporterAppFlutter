import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/screens/LoginScreens/loginScreen.dart';
import 'package:get/get.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    super.initState();
     Timer(Duration(seconds: 3), () => Get.off(() => LoginScreen()));

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.only(right: space_2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(
              height: space_4,
            ),
            Image(image: AssetImage("assets/images/liveasyTruck.png")),

            SizedBox(
              height: space_2,
            ),
             Container(
              child: Column(
                children: [
                  Image(
                    image: AssetImage("assets/images/logoSplashScreen.png"),

                    height: space_12,

                  ),
                  // Image(
                  //   image: AssetImage("assets/images/tagLine.png"),
                  //   height: space_3,
                  // )
                ],
               ),
             ),
          ],
        ),
      ),
    );
  }
}
