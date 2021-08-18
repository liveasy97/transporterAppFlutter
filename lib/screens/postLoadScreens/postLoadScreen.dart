import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/myLoadPages/deliveredScreen.dart';
import 'package:liveasy/screens/myLoadPages/myLoadsScreen.dart';
import 'package:liveasy/screens/myLoadPages/onGoingScreen.dart';
import 'package:liveasy/widgets/Header.dart';
import 'package:liveasy/widgets/OrderScreenNavigationBarButton.dart';
import 'package:liveasy/widgets/buttons/postLoadButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PostLoadScreen extends StatefulWidget {
  @override
  _PostLoadScreenState createState() => _PostLoadScreenState();
}

class _PostLoadScreenState extends State<PostLoadScreen> {
  //Page Controller
  PageController pageController = PageController(initialPage: 0);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, space_2),
          child: Column(
            children: [
              Header(reset: false, text: AppLocalizations.of(context)!.loads, backButton: false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrderScreenNavigationBarButton(
                      text: AppLocalizations.of(context)!.my_loads,
                      value: 0,
                      pageController: pageController),
                  OrderScreenNavigationBarButton(
                      text: AppLocalizations.of(context)!.on_going,
                      value: 1,
                      pageController: pageController),
                  OrderScreenNavigationBarButton(
                      text: AppLocalizations.of(context)!.completed,
                      value: 2,
                      pageController: pageController)
                ],
              ),
              Divider(
                color: textLightColor,
                thickness: 1,
              ),
              Stack(
                // alignment: Alignment.center,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          providerData.updateUpperNavigatorIndex(value);
                        });
                      },
                      children: [
                        MyLoadsScreen(),
                        OngoingScreen(),
                        DeliveredScreen(),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 25),
                      child: PostButtonLoad()),
                  // Positioned.fill(
                  //   top: 550,
                  //   child: Align(
                  //       alignment: Alignment.center, child: PostButtonLoad()),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
