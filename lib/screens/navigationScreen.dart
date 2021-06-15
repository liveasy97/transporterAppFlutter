import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/accountScreens/accountVerificationPage1.dart';
import 'package:liveasy/screens/home.dart';
import 'package:liveasy/widgets/bottomNavigationIconWidget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'TruckScreens/myTrucksScreen.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Widget> screens = [
    HomeScreen(),
    MyTrucks(),
    Text(""),
    Text(""),
    AccountVerificationPage1(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: statusBarColor, // color of status bar which displays time on a phone
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int pressedIndex) {
            Provider.of<ProviderData>(context, listen: false)
                .updateIndex(pressedIndex);
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
              label: ("Home"),
            ),
            BottomNavigationBarItem(
              icon: BottomNavigationIconWidget(
                iconPath: "myTrucksIcon.png",
              ),
              activeIcon: BottomNavigationIconWidget(
                iconPath: "activeMyTrucksIcon.png",
              ),
              label: ("My Trucks"),
            ),
            BottomNavigationBarItem(
              icon: BottomNavigationIconWidget(
                iconPath: "postLoadIcon.png",
              ),
              activeIcon: BottomNavigationIconWidget(
                iconPath: "activePostLoadIcon.png",
              ),
              label: ("Post Load"),
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
              label: ("Account"),
            ),
          ],
          currentIndex: Provider.of<ProviderData>(context).index,
        ),
        body: SafeArea(
          child: Center(
              child: screens.elementAt(
                  Provider.of<ProviderData>(context).index)),
        ),
    );
  }
}
