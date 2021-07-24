import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/buttons/getStartedButton.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.only(left: space_4, right: space_4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(space_5, space_8, space_5, space_0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: space_5, right: space_5),
                        child: Image(
                            image: AssetImage("assets/icons/welcomeIcon.png")),
                      ),
                      Text(
                        "WELCOME!",
                        style: TextStyle(
                            fontSize: size_11, fontWeight: boldWeight),
                      ),
                      SizedBox(
                        height: space_6,
                      ),
                      Text(
                        "Select Language",
                        style: TextStyle(
                            fontSize: size_10, fontWeight: normalWeight),
                      ),
                      SizedBox(
                        height: space_5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              height: space_8,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: navy),
                                  borderRadius:
                                      BorderRadius.circular(radius_1)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "English",
                                    style: TextStyle(
                                        color: navy,
                                        fontSize: size_9,
                                        fontWeight: normalWeight),
                                  ),
                                  Image(
                                    image: AssetImage("assets/icons/tick.png"),
                                    width: space_3,
                                    height: space_3,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: space_2,
                          ),
                          Expanded(
                            child: Container(
                              height: space_8,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: darkGreyColor),
                                  borderRadius:
                                      BorderRadius.circular(radius_1)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: space_2),
                                    child: Text(
                                      "Hindi",
                                      style: TextStyle(
                                          color: darkGreyColor,
                                          fontSize: size_9,
                                          fontWeight: normalWeight),
                                    ),
                                  ),
                                  Image(
                                    image: AssetImage("assets/icons/tick.png"),
                                    width: space_3,
                                    height: space_3,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: space_5,
                      ),
                      GetStartedButton()
                    ],
                  ),
                ),
              ),
              color: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius_5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
