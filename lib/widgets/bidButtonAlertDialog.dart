import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/bidButtonSendRequest.dart';
import 'package:liveasy/widgets/cancelButton.dart';
bool temp = true;

Future<void> showInformationDialog(BuildContext context) async {
      return await showDialog(
          context: context,
          builder: (context) {
    return StatefulBuilder(builder: (context,setState){
      return ListView(physics: NeverScrollableScrollPhysics(),
        children: [
          AlertDialog(
            title: Text(
              "Please enter your rate",
              style: TextStyle(fontSize: size_9, fontWeight: normalWeight),
            ),
            content: Column(mainAxisSize: MainAxisSize.min,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextButton(style: ButtonStyle(
                        backgroundColor: temp ? MaterialStateProperty.all(
                            priceBackground) : MaterialStateProperty.all(
                            white)),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: space_3,),
                        child: Text(
                          "Per Truck",
                          style: TextStyle(
                              fontWeight: mediumBoldWeight,
                              fontSize: size_7,
                              color: darkBlueColor),
                        ),
                      ),
                      onPressed:(){
                        setState(() {
                          temp=true;
                        });
                      },
                    ),
                    TextButton(style: ButtonStyle(
                        backgroundColor: temp ? MaterialStateProperty.all(
                            white) : MaterialStateProperty.all(
                            priceBackground)),
                      child: Padding(
                        padding:EdgeInsets.symmetric(horizontal: space_3,),
                        child: Text(
                          "Per Tonne",
                          style: TextStyle(
                              fontWeight: mediumBoldWeight,
                              fontSize: size_7,
                              color: darkBlueColor),
                        ),
                      ),
                      onPressed:(){
                        setState(() {
                          temp=false;
                        });
                      },
                    )
                  ],
                ),
                Container(height: space_7+2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Color(0xFF878787))),
                  child: Padding(
                    padding:  EdgeInsets.only(left: space_2-2, right: space_2-2,),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Eg 4000",
                        hintStyle: TextStyle(color: Color(0xFF979797)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(top: space_16+6,bottom: space_4+2),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [BidButtonSendRequest(), CancelButton()],
                ),
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),),
            insetPadding: EdgeInsets.symmetric(vertical: space_16*3,horizontal: space_4),
          ),
        ],
      );
    });
  });
}
