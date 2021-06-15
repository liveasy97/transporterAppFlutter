import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/screens/findLoadScreen.dart';
import 'package:liveasy/widgets/accountNotVerifiedWidget.dart';
import 'package:liveasy/widgets/bonusWidget.dart';
import 'package:liveasy/widgets/buyGpsWidget.dart';
import 'package:liveasy/widgets/drawerWidget.dart';
import 'package:liveasy/widgets/helpButtonWidget.dart';
import 'package:liveasy/widgets/liveasyTitleTextWidget.dart';
import 'package:liveasy/widgets/referAndEarnWidget.dart';
import 'package:liveasy/widgets/searchLoadWidget.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/widgets/suggestedLoadsWidget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(
          mobileNum: transporterIdController.mobileNum.value,
        ),
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(0, space_4, 0, space_2),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: space_4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          icon: Icon(
                            Icons.list,
                            size: space_6,
                          ),
                        ),
                        SizedBox(
                          width: space_2,
                        ),
                        LiveasyTitleTextWidget(),
                      ],
                    ),
                    HelpButtonWidget()
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(space_4, space_4, space_4, space_5),
                child: SearchLoadWidget(
                  hintText: "Search",
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Get.to(() => FindLoadScreen());
                  },
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: space_4),
                  child: SuggestedLoadsWidget()),
              SizedBox(
                height: space_4,
              ),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  controller: ScrollController(initialScrollOffset: 110),
                  children: [
                    ReferAndEarnWidget(height: 100, width: 180),
                    SizedBox(
                      width: space_4,
                    ),
                    BuyGpsWidget(
                      height: 100,
                      width: 180,
                    ),
                    SizedBox(
                      width: space_4,
                    ),
                    BonusWidget(
                      height: 100,
                      width: 180,
                    ),
                  ],
                ),
              ),
              transporterIdController.transporterApproved.value == false
                  ? AccountNotVerifiedWidget()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
