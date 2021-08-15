import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';

import 'package:liveasy/constants/fontSize.dart';

import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/providerClass/drawerProviderClassData.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/LoginScreens/loginScreen.dart';
import 'package:liveasy/screens/buyGpsScreen.dart';
import 'package:liveasy/screens/languageSelectionScreen.dart';
import 'package:liveasy/widgets/alertDialog/addDriverAlertDialog.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  final String mobileNum;
  final String userName;
  final String? imageUrl;

  DrawerWidget(
      {required this.mobileNum, required this.userName, this.imageUrl});

  final padding = EdgeInsets.only(left: space_1, right: space_7);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String name;
    String image;
    image =
        (imageUrl == null ? "assets/icons/defaultAccountIcon.png" : imageUrl)!;
    name = userName.length > 17 ? userName.substring(0, 15) + "..." : userName;

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(radius_6),
          bottomRight: Radius.circular(radius_6)),
      child: Container(
        width: width / 1.4,
        child: Drawer(
          child: Material(
              color: fadeGrey,
              child: Container(
                child: ListView(
                  children: [
                    SizedBox(
                      height: space_9,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: space_4),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: radius_7,
                            backgroundColor: white,
                            child: Container(
                              height: space_7,
                              width: space_7,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(image),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: space_2,
                          ),
                          name != " " ?Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                alignment: Alignment.topLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontWeight: mediumBoldWeight,
                                    fontSize: size_7,
                                    fontFamily: 'montserrat',
                                  ),
                                ),
                              ),
                              SizedBox(height: space_2),
                              Text(mobileNum),
                            ],
                          ):
                          Text(mobileNum),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: space_8,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectItem(context, NavigationItem.MyAccount);
                        Provider.of<ProviderData>(context, listen: false).updateIndex(4);
                      },
                      child: drawerMenuItem(
                          context: context,
                          item: NavigationItem.MyAccount,
                          text: "My Account",
                          image: 'assets/icons/person.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectItem(context, NavigationItem.Language);
                        Navigator.of(context).pop();
                        Get.to(LanguageSelectionScreen());
                      },
                      child: drawerMenuItem(
                          context: context,
                          item: NavigationItem.Language,
                          text: "Language",
                          image: 'assets/icons/languageIcon.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectItem(context, NavigationItem.AddDriver);
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) => AddDriverAlertDialog());
                      },
                      child: drawerMenuItem(
                          context: context,
                          item: NavigationItem.AddDriver,
                          text: "Add Driver",
                          image: 'assets/icons/driverHandle.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectItem(context, NavigationItem.BuyGps);
                        Navigator.of(context).pop();
                        Get.to(BuyGpsScreen());
                      },
                      child: drawerMenuItem(
                          context: context,
                          item: NavigationItem.BuyGps,
                          text: "Buy GPS",
                          image: 'assets/icons/gps.png'),
                    ),
                    SizedBox(
                      height: space_5,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: space_4),
                      child: Divider(
                        color: black,
                      ),
                    ),
                    SizedBox(
                      height: space_3,
                    ),
                    ListTile(

                      title: Container(
                        margin: EdgeInsets.only(left: space_4),
                        child: Text("About Us",
                            style: TextStyle(
                                color: darkBlueColor,
                                fontSize: size_8,
                                fontFamily: 'montserrat',
                                fontWeight: regularWeight)),
                      ),
                    ),
                    ListTile(
                      title: Container(
                        margin: EdgeInsets.only(left: space_4),
                        child: Text("Contact Us",
                            style: TextStyle(
                                color: darkBlueColor,
                                fontSize: size_8,
                                fontFamily: 'montserrat',
                                fontWeight: regularWeight)),
                      ),
                    ),
                    SizedBox(
                      height: space_3,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: space_4),
                      child: Divider(
                        color: black,
                      ),
                    ),
                    SizedBox(
                      height: space_5,
                    ),
                    GestureDetector(
                      onTap: () {
                        // FirebaseAuth.instance.signOut();
                        // Get.offAll(LoginScreen());
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            contentPadding: EdgeInsets.fromLTRB(space_6, space_7, space_6, space_4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
                            ),
                            title: const Text('Are you sure? You want to logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, )),
                            //content: const Text('Confirm?'),
                            actions: <Widget>[

                              ElevatedButton(

                                onPressed: () { FirebaseAuth.instance.signOut();
                        Get.offAll(LoginScreen());
                        },
                                child: Text('Ok'),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: darkBlueColor),
                                  )),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(darkBlueColor),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel',style: TextStyle(color: darkBlueColor)),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(color: darkBlueColor),
                                  )),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(statusBarColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text("Logout",
                            style: TextStyle(
                                color: black,
                                fontSize: size_8,
                                fontFamily: 'montserrat',
                                fontWeight: regularWeight)),
                        leading: Container(
                            margin: EdgeInsets.only(left: space_4),
                            child: Icon(
                              Icons.logout,
                              color: darkBlueColor,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: space_4,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget drawerMenuItem({
    required BuildContext context,
    required NavigationItem item,
    required String text,
    required String image,
  }) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(radius_2),
          bottomRight: Radius.circular(radius_2)),
      child: ListTile(
        selected: isSelected,
        selectedTileColor: lightGrey,
        leading: Container(
          margin: EdgeInsets.only(left: space_4),
          child: Image(
            image: AssetImage(image),
            width: space_3,
            height: space_4,
          ),
        ),
        title: Text(text,
            style: TextStyle(
                color: isSelected ? darkBlueColor : black,
                fontSize: size_8,
                fontFamily: 'montserrat',
                fontWeight: isSelected ? boldWeight : regularWeight)),
      ),
    );
  }

  void selectItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);
  }

}



