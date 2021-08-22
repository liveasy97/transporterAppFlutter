import 'dart:async';
import 'dart:developer';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:get/get.dart';
import 'package:liveasy/screens/errorScreen.dart';

import 'package:liveasy/screens/network%20error/noInternet.dart';
import 'package:liveasy/screens/spashScreenToGetTransporterData.dart';
import 'package:liveasy/translations/l10n.dart';
import 'package:liveasy/widgets/splashScreen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:connectivity/connectivity.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();

  runApp(MyApp());
}


class MyApp extends StatefulWidget{
  HomePage createState()=> HomePage();
}

class HomePage extends State<MyApp> {
   // late StreamSubscription _connectionChangeStream;
   // bool isOffline = false;

  var _connectionStatus = "Unknown";
 late  Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
     // ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
     // _connectionChangeStream = connectionStatus.connectionChange.listen(( connectionChanged){
     //   if(connectionChanged == false){
     //     setState((){});
     //   } else
     //     Get.to(NoInternet());
     // });


    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _connectionStatus = result.toString();
          print(_connectionStatus);
          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi) {
            // build(context);
            setState(() {});
          }
          else if (result == ConnectivityResult.none) {
            Get.to(NoInternet());
          }
        });
  }
  // void connectionChanged(dynamic hasConnection) {
  //   setState(() {
  //     isOffline = !hasConnection;
  //
  //   });
  // }
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(

      child: ChangeNotifierProvider<ProviderData>(
        create: (context) => ProviderData(),
        builder: (context, child) {
          return FutureBuilder(
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                final provider = Provider.of<ProviderData>(context);


                if (snapshot.connectionState == ConnectionState.done) {
                  if (FirebaseAuth.instance.currentUser == null) {
                    return GetMaterialApp(

                      builder: EasyLoading.init(),
                      theme: ThemeData(fontFamily: "montserrat"),
                      locale: provider.locale,
                      supportedLocales: L10n.all,
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],

                      home: SplashScreen(),
                    );
                  } else {
                    var mUser = FirebaseAuth.instance.currentUser;
                    var task = mUser!.getIdToken(true).then((value) {
                      // log(value);
                    });
                    return GetMaterialApp(

                      builder: EasyLoading.init(),
                      theme: ThemeData(fontFamily: "montserrat"),
                      locale: provider.locale,
                      supportedLocales: L10n.all,
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      home: SplashScreenToGetTransporterData(

                        mobileNum: FirebaseAuth.instance.currentUser!
                            .phoneNumber
                            .toString()
                            .substring(3, 13),
                      ),
                    );
                  }
                } else
                  return ErrorScreen();
              });
        },

      ),
    );
  }
}
