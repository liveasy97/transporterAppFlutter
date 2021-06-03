import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

class DriverDetailsLoadDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(space_1+3),
        color: darkBlueColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Padding(
             padding:  EdgeInsets.only(left: space_2,right: space_3),
             child: CircleAvatar(radius: space_10+4,
               backgroundImage: AssetImage(
                   "assets/images/defaultDriverImage.png"),
             ),
           ),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  "Ravi Singh",
                  style: TextStyle(
                      fontWeight: mediumBoldWeight,
                      color: white,
                      fontSize: size_9),
                ),
                SizedBox(
                  height: space_1 - 2,
                ),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: space_3+1,
                          width: space_3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/icons/buildingInnerIcon.png",
                                ),
                              )),
                        ),
                        Container(
                          height: space_3+1,
                          width: space_3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/icons/buildingOuterIcon.png",
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: space_1 - 2,
                    ),
                    Text(
                      "Asian Paints",
                      style: TextStyle(
                          fontWeight: normalWeight,
                          color: white,
                          fontSize: size_6),
                    ),
                  ],
                ),
                SizedBox(
                  height: space_1 - 1,
                ),
                Row(
                  children: [
                    Container(
                      height: space_3,
                      width: space_3-2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/icons/locationIcon.png",
                            ),
                          )),
                    ),
                    SizedBox(
                      width: space_1,
                    ),
                    Text(
                      "Madhya Pradesh",
                      style: TextStyle(
                          fontWeight: normalWeight,
                          color: white,
                          fontSize: size_6),
                    ),
                  ],
                ),
                SizedBox(
                  height: space_1 + 1,
                ),
                Container(
                  height: space_3,
                  width: space_10 - 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.81),
                    color: verifiedButtonColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: space_1 + 3,
                        width: space_1 + 3,
                        image: AssetImage(
                            "assets/icons/verifiedButtonIcon.png"),
                      ),
                      Text(
                        "verified",
                        style: TextStyle(
                            fontWeight: normalWeight,
                            fontSize: size_3 + 1),
                      ),
                    ],
                  ),
                )
              ],
            ),

        ],
      ),
    );
  }
}
