import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/widgets/accountVerification/companyIdInputWidget.dart';
import 'package:liveasy/widgets/accountVerification/elevatedButtonWidget.dart';
import 'package:liveasy/widgets/buttons/backButtonWidget.dart';
import 'package:liveasy/widgets/headingTextWidget.dart';
import 'package:liveasy/widgets/helpButtonWidget.dart';
import 'package:provider/provider.dart';

class AccountVerificationPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        BackButtonWidget(),
                        SizedBox(
                          width: space_3,
                        ),
                        HeadingTextWidget("My Account"),
                      ],
                    ),
                    HelpButtonWidget(),
                  ],
                ),
                SizedBox(
                  height: space_4,
                ),
                Row(
                  children: [
                    Text(
                      "For Posting Load ",
                      style: TextStyle(
                          fontSize: size_9,
                          color: liveasyBlackColor,
                          fontWeight: mediumBoldWeight),
                    ),
                    Text(
                      "(Optional)",
                      style:
                          TextStyle(fontSize: size_9, color: liveasyBlackColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: space_5,
                ),
                CompanyIdInputWidget(providerData: providerData,),
                ElevatedButtonWidget(
                    condition: providerData.companyIdProofPhotoFile != null,
                    text: "Verify",
                    onPressedConditionTrue: () {
                      //post The Data
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
