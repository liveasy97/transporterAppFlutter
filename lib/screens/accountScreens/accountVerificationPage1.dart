import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/getImageFromCamera.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/accountScreens/accountVerificationPage2.dart';
import 'package:liveasy/widgets/accountVerification/elevatedButtonWidget.dart';
import 'package:liveasy/widgets/headingTextWidget.dart';
import 'package:liveasy/widgets/helpButtonWidget.dart';
import 'package:liveasy/widgets/accountVerification/idInputWidget.dart';
import 'package:liveasy/widgets/accountVerification/profilePhoto.dart';
import 'package:provider/provider.dart';

class AccountVerificationPage1 extends StatefulWidget {
  @override
  _AccountVerificationPage1State createState() =>
      _AccountVerificationPage1State();
}

class _AccountVerificationPage1State extends State<AccountVerificationPage1> {
  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: space_2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadingTextWidget("My Account"),
                    HelpButtonWidget(),
                  ],
                ),
              ),
              SizedBox(
                height: space_3,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    getImageFromCamera(providerData.updateProfilePhoto);
                  },
                  child: ProfilePhotoWidget(
                    providerData: providerData,
                  ),
                ),
              ),
              SizedBox(
                height: space_4,
              ),
              IdInputWidget(
                providerData: providerData,
              ),
              ElevatedButtonWidget(
                  condition: providerData.profilePhotoFile != null &&
                      providerData.panFrontPhotoFile != null &&
                      providerData.panBackPhotoFile != null &&
                      providerData.addressProofPhotoFile != null,
                  text: "Next",
                  onPressedConditionTrue: () {
                    Get.to(() => AccountVerificationPage2());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
