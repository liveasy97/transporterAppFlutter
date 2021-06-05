import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/bidButtonSendRequest.dart';
import 'package:liveasy/widgets/cancelButton.dart';

class BidButtonWidget extends StatefulWidget {

  @override
  _BidButtonWidgetState createState() => _BidButtonWidgetState();
}

class _BidButtonWidgetState extends State<BidButtonWidget> {
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
                      Container(height: 37,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: Color(0xFF878787))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0,),
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
                      padding: EdgeInsets.only(top: 86.0,bottom: 22.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [BidButtonSendRequest(), CancelButton()],
                      ),
                    )
                  ],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),),
                 insetPadding: EdgeInsets.symmetric(vertical: 240.0,horizontal: 20.0),
                ),
             ],
           );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showInformationDialog(context);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        height: 31,
        width: 80,
        decoration: BoxDecoration(
            color: bidBackground, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            "Bid",
            style: TextStyle(
                color: Colors.white,
                fontWeight: normalWeight,
                fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}

