import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/raidus.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/getDriverDetailsFromDriverApi.dart';
import 'package:liveasy/functions/getTruckNoFromTruckApi.dart';
import 'package:liveasy/widgets/buttons/confirmButtonSendRequest.dart';
import 'package:liveasy/widgets/buttons/cancelButton.dart';

String _dropdownvalue1 = truckNoList[0].toString();
String _dropdownvalue2 = driverDetailsList[0].toString();

Future<void> showInformationDialog(
    BuildContext context, truckNoList, driverDetailsList) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              AlertDialog(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select a Truck",
                      style:
                          TextStyle(fontSize: size_9, fontWeight: normalWeight),
                    ),
                    SizedBox(
                      height: space_2,
                    ),
                    Container(
                      height: space_7 + 2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius_4 + 2),
                          border: Border.all(color: borderLightColor)),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: space_2 - 2,
                          right: space_2 - 2,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _dropdownvalue1,
                            icon: Icon(Icons.arrow_drop_down_circle_sharp),
                            iconEnabledColor: darkBlueColor,
                            style: TextStyle(
                                fontSize: size_7,
                                fontWeight: regularWeight,
                                color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                _dropdownvalue1 = newValue!;
                              });
                            },
                            items: truckNoList.map<DropdownMenuItem<String>>((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: space_2 + 2,
                    ),
                    Text(
                      "Select a Driver",
                      style:
                          TextStyle(fontSize: size_9, fontWeight: normalWeight),
                    ),
                    SizedBox(
                      height: space_2,
                    ),
                   Container(
                      height: space_7 + 2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius_4 + 2),
                          border: Border.all(color: Color(0xFF878787))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: space_2 - 2,
                          right: space_2 - 2,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _dropdownvalue2,
                            icon: Icon(Icons.arrow_drop_down_circle_sharp),
                            iconEnabledColor: darkBlueColor,
                            style: TextStyle(
                                fontSize: size_7,
                                fontWeight: regularWeight,
                                color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                _dropdownvalue2 = newValue!;
                              });
                            },
                            items: driverDetailsList.map<DropdownMenuItem<String>>((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: space_11, bottom: space_4 + 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [ConfirmButtonSendRequest(), CancelButton()],
                    ),
                  )
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
                ),
                insetPadding: EdgeInsets.symmetric(
                    vertical: space_16 * 3, horizontal: space_4),
              ),
            ],
          );
        });
      });
}



