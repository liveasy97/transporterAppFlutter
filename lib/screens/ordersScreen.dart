import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/widgets/Header.dart';
import 'package:liveasy/widgets/OrderScreenNavigationBarButton.dart';
import 'package:liveasy/screens/TransporterOrders/biddingScreenTransporterSide.dart';
import 'package:provider/provider.dart';
import 'TransporterOrders/deliveredScreenOrders.dart';
import 'TransporterOrders/onGoingScreenOrders.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    PageController pageController =
        PageController(initialPage: providerData.upperNavigatorIndex);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, space_2),
          child: Column(
            children: [
              Header(
                reset: false,
                text: 'Orders',
                backButton: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrderScreenNavigationBarButton(
                    text: AppLocalizations.of(context)!.bids,
                    value: 0,
                    pageController: pageController,
                  ),
                  OrderScreenNavigationBarButton(
                    text: AppLocalizations.of(context)!.on_going,
                    value: 1,
                    pageController: pageController,
                  ),
                  OrderScreenNavigationBarButton(
                    text: AppLocalizations.of(context)!.completed,
                    value: 2,
                    pageController: pageController,
                  )
                ],
              ),
              Divider(
                color: textLightColor,
                thickness: 1,
              ),
              Stack(
                children: [
                  Container(
                    height: 600,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          providerData.updateUpperNavigatorIndex(value);
                        });
                      },
                      children: [
                        BiddingScreenTransporterSide(),
                        OngoingScreenOrders(),
                        DeliveredScreenOrders(),
                      ],
                    ),
                  ),

                  // Positioned(
                  //   top: 50,
                  //   child: Align(
                  //       alignment: Alignment.center,
                  //       child: PostButtonLoad()
                  //   ),
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
