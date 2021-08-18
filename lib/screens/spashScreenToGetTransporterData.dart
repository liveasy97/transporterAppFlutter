import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/trasnporterApis/runTransporterApiPost.dart';
import 'package:liveasy/screens/LoginScreens/loginScreen.dart';
import 'package:get/get.dart';
import 'package:liveasy/screens/navigationScreen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:liveasy/NoInternet.dart';

class SplashScreenToGetTransporterData extends StatefulWidget {
  final String mobileNum;
  SplashScreenToGetTransporterData({required this.mobileNum});

  @override
  _SplashScreenToGetTransporterDataState createState() =>
      _SplashScreenToGetTransporterDataState();
}

class _SplashScreenToGetTransporterDataState
    extends State<SplashScreenToGetTransporterData> {



  @override
  void initState() {
    super.initState();


        getData();

  }

  getData() async{
    String? transporterId = await runTransporterApiPost(mobileNum: widget.mobileNum);
    if (transporterId != null){
      Timer(Duration(milliseconds: 1000), () => Get.off(() => NavigationScreen()));
    }
    else {
      transporterId = await runTransporterApiPost(mobileNum: widget.mobileNum);
      if (transporterId != null) {
        Timer(
            Duration(milliseconds: 1), () => Get.off(() => NavigationScreen()));
      } else {
        Timer(
            Duration(milliseconds: 1), () => Get.off(() => NavigationScreen()));
        //TODO make a screen to show Api not working
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
        child: Container(
          color: white,
          padding: EdgeInsets.only(right: space_2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    SizedBox(
                      height: space_3,
                    ),
                    Image(
                      image: AssetImage("assets/images/tagLine.png"),
                      height: space_3,
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
