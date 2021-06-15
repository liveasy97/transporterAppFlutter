//TODO:to be refactored
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/screens/LoginScreens/loginScreen.dart';
class DrawerWidget extends StatelessWidget {
  final String mobileNum;
  DrawerWidget({required this.mobileNum});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: space_6,
                    child: Icon(Icons.home),
                  ),
                  SizedBox(
                    width: space_3,
                  ),
                  Text(
                    mobileNum == "" ?
                    '+911234567891'
                    : "+91$mobileNum"
                    ,
                    style: TextStyle(fontSize: size_9),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.offAll(LoginScreen());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: space_3),
                child: ListTile(
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: size_9,
                    ),
                  ),
                  trailing: Icon(
                    Icons.exit_to_app,
                    size: space_6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
