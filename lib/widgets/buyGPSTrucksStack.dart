import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/buyGPSboolController.dart';
import 'package:liveasy/widgets/buttons/BuyGPSPayButton.dart';
import 'package:liveasy/widgets/loadingWidgets/truckLoadingLongWidgets.dart';
import 'package:liveasy/widgets/trucksLongCard.dart';
import 'package:liveasy/functions/buyGPSApiCalls.dart';
import 'package:flutter_config/flutter_config.dart';

class BuyGPSTrucksStack extends StatefulWidget {
  bool? loading;
  var truckDataList = [];
  ScrollController scrollController;
  String? groupValue;
  String? durationGroupValue;
  bool locationPermissionis;
  String? currentAddress;
  var context;

  BuyGPSTrucksStack({
    Key? key,
    required this.loading,
    required this.truckDataList,
    required this.scrollController,
    required this.groupValue,
    required this.durationGroupValue,
    required this.locationPermissionis,
    required this.currentAddress,
    required this.context
  }) : super(key: key);

  @override
  _BuyGPSTrucksStackState createState() => _BuyGPSTrucksStackState();
}

class _BuyGPSTrucksStackState extends State<BuyGPSTrucksStack> {
  final String buyGPSApiUrl = FlutterConfig.get('buyGPSApiUrl');
  BuyGPSHudController updateButtonController = Get.put(BuyGPSHudController());
  // bool isDisable = false;
  BuyGPSApiCalls buyGPSApiCalls = BuyGPSApiCalls();
  int? _selectedIndex;
  String? truckID;
  String? gpsId;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }
  @override
  void initState() {
    super.initState();
    updateButtonController.updateTruckID(null);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - (space_44 * 2),
            width: double.infinity,
            child: widget.loading!
                ? TruckLoadingLongWidgets()
                : widget.truckDataList.isEmpty
                ? Container(
              height: space_20,
              padding: EdgeInsets.only(top: space_4),
              child: Column(
                children: [
                  Image(
                    image: AssetImage(
                        'assets/images/TruckListEmptyImage.png'),
                    height: (space_25 + 2),
                    width: (space_25 + 2),
                  ),
                  SizedBox(
                    height: space_2,
                  ),
                  Text(
                    'Looks like you have not added any Trucks!',
                    style: TextStyle(
                        fontSize: size_8,
                        color: grey
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
                : ListView.builder(
                controller: widget.scrollController,
                padding: EdgeInsets.only(bottom: space_15),
                itemCount: widget.truckDataList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onSelected(index);
                      truckID = widget.truckDataList[index].truckId;
                      updateButtonController.updateTruckID(truckID);
                      if(updateButtonController.updateRadioButton.value == false || truckID == null) {
                        updateButtonController.updateButtonHud(false);
                      } else {
                        updateButtonController.updateButtonHud(true);
                      }
                    },
                    child: TrucksLongCard(
                        truckData: widget.truckDataList[index],
                        borderCard: _selectedIndex != null && _selectedIndex == index
                            ? Border.all(color: bidBackground)
                            : null
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: space_2),
            child: BuyGPSPayButton(
                durationGroupValue: widget.durationGroupValue,
                truckID: truckID,
                groupValue: widget.groupValue,
                currentAddress: widget.currentAddress,
                context: widget.context,
                locationPermissionis: widget.locationPermissionis
            ),
          )
        ]
    );
  }
}
