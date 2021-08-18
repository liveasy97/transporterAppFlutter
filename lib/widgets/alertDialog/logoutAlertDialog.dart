import 'package:flutter/material.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/screens/LoginScreens/loginScreen.dart';


class logoutAlertDialogBox extends StatelessWidget {
  const logoutAlertDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size_18,
      height:size_17,
      child: AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(space_6, space_7, space_6, space_4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
      ),
      title:  Text('Are you sure? You want to \n logout', style: TextStyle(fontSize: size_9,
          fontWeight: fontWeight500, fontFamily: 'montserrat'), ),

        actionsPadding: EdgeInsets.only(bottom: space_3),


      actions: <Widget>[

        SizedBox(
          width:size_16,
          height: size_15 + 1,


        child: ElevatedButton(

          onPressed: () { FirebaseAuth.instance.signOut();
          Get.offAll(LoginScreen());
          },
          child: Text('Ok',style: TextStyle(color: white, fontSize: size_8),),
          style: ButtonStyle(

            shape: MaterialStateProperty.all<

                RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(space_4),
              side: BorderSide(color: darkBlueColor),

            )),

            backgroundColor:
            MaterialStateProperty.all<Color>(darkBlueColor),
          ),
        ),
        ),
        SizedBox(
          width:2,
        ),
        SizedBox(
          width:size_16,
          height: size_15 + 1,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel',style: TextStyle(color: darkBlueColor )),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: darkBlueColor),
            )),
            backgroundColor:
            MaterialStateProperty.all<Color>(statusBarColor),
          ),
        ),
        ),      ],
      ),
    );
  }
}