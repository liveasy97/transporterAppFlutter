// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:get/get.dart';
import 'package:liveasy/screens/errorScreen.dart';
import 'package:liveasy/screens/spashScreenToGetTransporterData.dart';
import 'package:liveasy/widgets/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderData>(
      create: (context) => ProviderData(),
      child: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (FirebaseAuth.instance.currentUser == null) {
                return GetMaterialApp(
                  themeMode: ThemeMode.system,
                  theme: ThemeData(fontFamily: "montserrat"),
                  home: SplashScreen(),
                );
              } else {
                return GetMaterialApp(
                  themeMode: ThemeMode.system,
                  theme: ThemeData(fontFamily: "montserrat"),
                  home: SplashScreenToGetTransporterData(
                    mobileNum: FirebaseAuth.instance.currentUser.phoneNumber
                        .toString()
                        .substring(3, 13),
                  ),
                );
              }
            } else
              return ErrorScreen();
          }),
    );
  }
}
