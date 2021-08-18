import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/loadApis/findLoadByLoadID.dart';
import 'package:liveasy/models/loadDetailsScreenModel.dart';
import 'package:liveasy/screens/ordersScreen.dart';
import 'package:liveasy/screens/postLoadScreens/postLoadScreen.dart';
import 'package:liveasy/widgets/accountVerification/accountPageUtil.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/home.dart';
import 'package:liveasy/widgets/bottomNavigationIconWidget.dart';
import 'package:provider/provider.dart';
import 'TruckScreens/myTrucksScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  List<LoadDetailsScreenModel> data = [];
  String? loadID;
  LoadDetailsScreenModel loadDetailsScreenModel = LoadDetailsScreenModel();

  TransporterIdController tIdController = Get.find<TransporterIdController>();

  var screens = [
    HomeScreen(),
    MyTrucks(),
    PostLoadScreen(),
    OrdersScreen(),
    AccountPageUtil(),
  ];

  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          final Uri? deepLink = dynamicLink?.link;

          if (deepLink != null) {
              loadID = deepLink.path;
              findLoadByLoadID(loadID!);
          }
        },
        onError: (OnLinkErrorException e) async {
          print('onLinkError');
          print(e.message);
        }
    );

    final PendingDynamicLinkData? dataLink = await FirebaseDynamicLinks.instance
        .getInitialLink();
    final Uri? deepLink = dataLink?.link;

    if (deepLink != null) {
      loadID = deepLink.path;
      findLoadByLoadID(loadID!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData =
        Provider.of<ProviderData>(context, listen: false);
    return Scaffold(
      backgroundColor: statusBarColor,
      // color of status bar which displays time on a phone
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int pressedIndex) {
          // Provider.of<ProviderData>(context, listen: false)
          //     .updateIndex(pressedIndex);
          providerData.updateUpperNavigatorIndex(0);
          providerData.updateIndex(pressedIndex);
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
            label: ("Orders"),
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
        currentIndex: Provider.of<ProviderData>(context).index,
      ),
      body: SafeArea(
        child: Center(
            child: screens.elementAt(Provider.of<ProviderData>(context).index)),
      ),
    );
  }
}
