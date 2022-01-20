import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/controller/navigationIndexController.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/AppVersionCheck.dart';
import 'package:liveasy/functions/getDriverDetailsFromDriverId.dart';
import 'package:liveasy/functions/loadApis/findLoadByLoadID.dart';
import 'package:liveasy/functions/trackScreenFunctions.dart';
import 'package:liveasy/functions/truckApis/truckApiCalls.dart';
import 'package:liveasy/models/driverModel.dart';
import 'package:liveasy/models/loadDetailsScreenModel.dart';
import 'package:liveasy/screens/noInternetScreen.dart';
import 'package:liveasy/screens/ordersScreen.dart';
import 'package:liveasy/screens/postLoadScreens/postLoadScreen.dart';
import 'package:liveasy/screens/trackScreen.dart';
import 'package:liveasy/widgets/accountVerification/accountPageUtil.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/home.dart';
import 'package:liveasy/widgets/bottomNavigationIconWidget.dart';
import 'package:provider/provider.dart';
import 'TruckScreens/myTrucksScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationScreen extends StatefulWidget {
  var initScreen;
  NavigationScreen({this.initScreen});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<LoadDetailsScreenModel> data = [];
  String? loadID;
  LoadDetailsScreenModel loadDetailsScreenModel = LoadDetailsScreenModel();
  TruckApiCalls _truckApiCalls = TruckApiCalls();
  var gpsDataHistory;
  var gpsStoppageHistory;
  var gpsData;
  var gpsRoute;
  late Map truckdata;
  DateTime yesterday =
      DateTime.now().subtract(Duration(days: 1, hours: 5, minutes: 30));
  late String from;
  late String to;
  DateTime now = DateTime.now().subtract(Duration(hours: 5, minutes: 30));
  TransporterIdController tIdController = Get.find<TransporterIdController>();
  NavigationIndexController navigationIndex =
      Get.put(NavigationIndexController(), permanent: true);
  var screens = [
    HomeScreen(),
    MyTrucks(),
    PostLoadScreen(),
    OrdersScreen(),
    AccountPageUtil(),
  ];

  @override
  void initState() {
    if (widget.initScreen != null) {
      navigationIndex.updateIndex(widget.initScreen);
    }
    from = yesterday.toIso8601String();
    to = now.toIso8601String();
    super.initState();
    this.initDynamicLinks();
    this.checkUpdate();
  }

  void checkUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = (prefs.getBool('isFirstTime') ?? true);
    try {
      if (isFirstTime == true) {
        await prefs.setBool('isFirstTime', false);
        versionCheck(context);
      }
    } catch (e) {
      print(e);
    }
  }

  void _handleDynamicLink(PendingDynamicLinkData? dataLink) async {
    final Uri? deepLink = dataLink?.link;

    if (deepLink != null) {
      if (deepLink.queryParameters.containsKey('deviceId')) {
        EasyLoading.instance
          ..indicatorType = EasyLoadingIndicatorType.ring
          ..indicatorSize = 45.0
          ..radius = 10.0
          ..maskColor = darkBlueColor
          ..userInteractions = false
          ..backgroundColor = darkBlueColor
          ..dismissOnTap = false;
        EasyLoading.show(
          status: "Loading...",
        );
        int deviceId = int.parse(deepLink.queryParameters['deviceId']!);
        print(deviceId);

        String? truckId = deepLink.queryParameters['truckId'];
        print(truckId);
        truckdata = await _truckApiCalls.getDataByTruckId(truckId!);
        String driverId = truckdata['driverId'];
        print("1st pass");
        print(driverId);
        DriverModel driverModel = await getDriverDetailsFromDriverId(driverId);
        print("2nd pass");
        gpsData = await mapUtil.getTraccarPosition(deviceId: deviceId);

        gpsDataHistory = await getDataHistory(gpsData.last.deviceId, from, to);
        gpsStoppageHistory =
            await getStoppageHistory(gpsData.last.deviceId, from, to);

        print(truckdata['truckNo']);
        print(driverModel.driverName);
        print(driverModel.phoneNum);
        print('here');
        //   print(imei);
        EasyLoading.dismiss();
        Get.to(() => TrackScreen(
              gpsData: gpsData,
              gpsDataHistory: gpsDataHistory,
              gpsStoppageHistory: gpsStoppageHistory,
              deviceId: deviceId,
              TruckNo: truckdata['truckNo'],
              driverName: driverModel.driverName,
              driverNum: driverModel.phoneNum,
              truckId: truckId,
            ));
      } else {
        loadID = deepLink.path;
        findLoadByLoadID(loadID!);
      }
    }
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      _handleDynamicLink(dynamicLink);
      /*       EasyLoading.instance
              ..indicatorType = EasyLoadingIndicatorType.ring
              ..indicatorSize = 45.0
              ..radius = 10.0
              ..maskColor = darkBlueColor
              ..userInteractions = false
              ..backgroundColor = darkBlueColor
              ..dismissOnTap = false;
            EasyLoading.show(
              status: "Loading...",
            );
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        if (deepLink.queryParameters.containsKey('imei')) {
          String? imei = deepLink.queryParameters['imei'];  
          print(imei);
          
          String? truckId = deepLink.queryParameters['truckId']; 
          print(truckId);
          truckdata =  await _truckApiCalls.getDataByTruckId(truckId!);
          String driverId = truckdata['driverId'];
          print("1st pass");
          print(driverId);
          DriverModel driverModel = await getDriverDetailsFromDriverId(driverId);
          print("2nd pass");
          gpsDataHistory =  await getDataHistory(imei, dateFormat.format(DateTime.now().subtract(Duration(days: 1))),  dateFormat.format(DateTime.now()) );
          print("3rd pass$gpsDataHistory");
          gpsData = await mapUtil.getLocationByImei(imei: imei);
          print("4th pass $gpsData");
          gpsStoppageHistory = await  getStoppageHistory(imei, dateFormat.format(DateTime.now().subtract(Duration(days: 1))),  dateFormat.format(DateTime.now()));
          print("5th pass $gpsStoppageHistory");
          gpsRoute = await getRouteStatusList(imei, dateFormat.format(DateTime.now().subtract(Duration(days: 1))),  dateFormat.format(DateTime.now()));
          print("6th pass $gpsRoute");
          print(truckdata['truckNo']);
          print(driverModel.driverName);
          print(driverModel.phoneNum);
          print('here');
          print(imei);
          EasyLoading.dismiss();
          Get.to(() => TrackScreen(gpsData: gpsData,gpsDataHistory: gpsDataHistory,gpsStoppageHistory: gpsStoppageHistory ,routeHistory: gpsRoute,imei: imei,TruckNo: truckdata['truckNo'],driverName: driverModel.driverName,driverNum:driverModel.phoneNum,truckId: truckId,));
}
        else{
        loadID = deepLink.path;
        findLoadByLoadID(loadID!);
        }
      }*/
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData? dataLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDynamicLink(dataLink);
    /*   final Uri? deepLink = dataLink?.link;

    if (deepLink != null) {
      
      if (deepLink.queryParameters.containsKey('imei')) {
        EasyLoading.instance
              ..indicatorType = EasyLoadingIndicatorType.ring
              ..indicatorSize = 45.0
              ..radius = 10.0
              ..maskColor = darkBlueColor
              ..userInteractions = false
              ..backgroundColor = darkBlueColor
              ..dismissOnTap = false;
            EasyLoading.show(
              status: "Loading...",
            );
          String? imei = deepLink.queryParameters['imei'];  
          String? truckId = deepLink.queryParameters['truckId']; 
          truckdata =  await _truckApiCalls.getDataByTruckId(truckId!);
          String driverId = truckdata['driverId'];

          
          DriverModel driverModel = getDriverDetailsFromDriverId(driverId);
          EasyLoading.dismiss();
          gpsDataHistory =  await getDataHistory(imei, dateFormat.format(DateTime.now().subtract(Duration(days: 1))),  dateFormat.format(DateTime.now()) );
          EasyLoading.dismiss();
          gpsData = await mapUtil.getLocationByImei(imei: imei);
          gpsStoppageHistory = await  getStoppageHistory(imei, dateFormat.format(DateTime.now().subtract(Duration(days: 1))),  dateFormat.format(DateTime.now()));
          gpsRoute = await getRouteStatusList(imei, dateFormat.format(DateTime.now().subtract(Duration(days: 1))),  dateFormat.format(DateTime.now()));
        //  EasyLoading.dismiss();
          Get.to(() => TrackScreen(gpsData: gpsData,gpsDataHistory: gpsDataHistory,gpsStoppageHistory: gpsStoppageHistory ,routeHistory: gpsRoute,imei: imei,TruckNo: truckdata['truckNo'],driverName: driverModel.driverName,driverNum:driverModel.phoneNum,truckId: truckId,));
}
else{
      loadID = deepLink.path;
      findLoadByLoadID(loadID!);
}
*/
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Scaffold(
        backgroundColor: statusBarColor,
        // color of status bar which displays time on a phone
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              onTap: (int pressedIndex) {
                providerData.updateUpperNavigatorIndex(0);
                navigationIndex.updateIndex(pressedIndex);
              },
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              unselectedItemColor: grey,
              selectedItemColor: grey,
              selectedLabelStyle: TextStyle(color: flagGreen),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: BottomNavigationIconWidget(
                    iconPath: "homeIcon.png",
                  ),
                  activeIcon: BottomNavigationIconWidget(
                    iconPath: "activeHomeIcon.png",
                  ),
                  label: (AppLocalizations.of(context)!.home),
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationIconWidget(
                    iconPath: "myTrucksIcon.png",
                  ),
                  activeIcon: BottomNavigationIconWidget(
                    iconPath: "activeMyTrucksIcon.png",
                  ),
                  label: (AppLocalizations.of(context)!.my_truck),
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationIconWidget(
                    iconPath: "postLoadIcon.png",
                  ),
                  activeIcon: BottomNavigationIconWidget(
                    iconPath: "activePostLoadIcon.png",
                  ),
                  label: (AppLocalizations.of(context)!.my_loads),
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationIconWidget(
                    iconPath: "ordersIcon.png",
                  ),
                  activeIcon: BottomNavigationIconWidget(
                    iconPath: "activeOrdersIcon.png",
                  ),
                  label: (AppLocalizations.of(context)!.order),
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationIconWidget(
                    iconPath: "accountIcon.png",
                  ),
                  activeIcon: BottomNavigationIconWidget(
                    iconPath: "activeAccountIcon.png",
                  ),
                  label: (AppLocalizations.of(context)!.account),
                ),
              ],
              currentIndex: navigationIndex.index.value,
            )),
        body: Obx(
          () => SafeArea(
            child:
                Center(child: screens.elementAt(navigationIndex.index.value)),
          ),
        ));
  }
}
