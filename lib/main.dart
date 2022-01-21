import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:get/get.dart';
import 'package:liveasy/screens/errorScreen.dart';
import 'package:liveasy/screens/noInternetScreen.dart';
import 'package:liveasy/screens/spashScreenToGetTransporterData.dart';
import 'package:liveasy/translations/l10n.dart';
import 'package:liveasy/widgets/splashScreen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity/connectivity.dart';

var firebase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebase = Firebase.initializeApp();
  await GetStorage.init();
  await GetStorage.init('TransporterIDStorage');
  await FlutterConfig.loadEnvVariables();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _connectionStatus = "Unknown";
  bool isDisconnected = false;
  late Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    setState(() {});
    checkConnection();
    connectivityChecker();
  }

  void checkConnection() {
    configOneSignel();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      print(_connectionStatus);
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        if (isDisconnected) {
          isDisconnected = false;
          connectivityChecker();
          Get.back();
        }
      } else {
        if (!isDisconnected) {
          isDisconnected = true;
          Get.defaultDialog(
              barrierDismissible: false,
              content: NoInternetConnection.noInternetDialogue(),
              onWillPop: () async => false,
              title: "\nNo Internet",
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ));
        } else
          connectivityChecker();
      }
    });
  }

  Future<void> connectivityChecker() async {
    print("Checking internet...");
    try {
      await InternetAddress.lookup('google.com');
    } on SocketException catch (_) {
      isDisconnected = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.defaultDialog(
            barrierDismissible: false,
            content: NoInternetConnection.noInternetDialogue(),
            onWillPop: () async => false,
            title: "\nNo Internet",
            titleStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ));
      });
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void configOneSignel() {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    String oneSignalAppId = FlutterConfig.get('oneSignalAppId').toString();
    OneSignal.shared.setAppId(oneSignalAppId);
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: ChangeNotifierProvider<ProviderData>(
        create: (context) => ProviderData(),
        builder: (context, child) {
          return FutureBuilder(
              future: firebase,
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
                    return GetMaterialApp(
                      builder: EasyLoading.init(),
                      theme: ThemeData(
                          fontFamily: "montserrat",
                          appBarTheme: AppBarTheme(
                              color: statusBarColor,
                              iconTheme: IconThemeData(color: grey))),
                      locale: provider.locale,
                      supportedLocales: L10n.all,
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      home: SplashScreenToGetTransporterData(
                        mobileNum: FirebaseAuth
                            .instance.currentUser!.phoneNumber
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
