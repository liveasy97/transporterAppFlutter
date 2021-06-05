import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/confirmButtonSendRequest.dart';
import 'package:liveasy/widgets/cancelButton.dart';

String _dropdownvalue1 = "Truck-1";
String _dropdownvalue2 = "Mukul-8886551";

Future<void> showInformationDialog(BuildContext context) async {
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
                      style: TextStyle(
                          fontSize: size_9, fontWeight: normalWeight),
                    ),
                    SizedBox(
                      height: space_2,
                    ),
                    Container(
                      height: space_7+2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Color(0xFF878787))),
                      child: Padding(
                        padding:  EdgeInsets.only(
                          left: space_2-2,
                          right: space_2-2,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _dropdownvalue1,
                            icon: Icon(Icons.arrow_drop_down_circle_sharp),
                            iconEnabledColor: darkBlueColor,
                            style: TextStyle(fontSize: size_7,fontWeight: regularWeight,color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                _dropdownvalue1 = newValue!;
                              });
                            },
                            items: <String>[
                              'Truck-1',
                              'Truck-2',
                              'Truck-3',
                              'Truck-4'
                            ].map<DropdownMenuItem<String>>((String value) {
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
                      style: TextStyle(
                          fontSize: size_9, fontWeight: normalWeight),
                    ),
                    SizedBox(
                      height: space_2,
                    ),
                    Container(
                      height: 37,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Color(0xFF878787))),
                      child: Padding(
                        padding:  EdgeInsets.only(
                          left: space_2-2,
                          right: space_2-2,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _dropdownvalue2,
                            icon: Icon(Icons.arrow_drop_down_circle_sharp),
                            iconEnabledColor: darkBlueColor,
                            style: TextStyle(fontSize: size_7,fontWeight: regularWeight,color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                _dropdownvalue2 = newValue!;
                              });
                            },
                            items: <String>[
                              'Mukul-8886551',
                              'Rajesh-111115',
                              'Pawan-444445',
                              'Naman-999987'
                            ].map<DropdownMenuItem<String>>((String value) {
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
                    padding: EdgeInsets.only(top: space_11, bottom: space_4+2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [ConfirmButtonSendRequest(), CancelButton()],
                    ),
                  )
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                insetPadding:
                EdgeInsets.symmetric(vertical: space_16*3, horizontal: space_4),
              ),
            ],
          );
        });
      });
}