import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

// ignore: must_be_immutable
class ElevatedButtonWidget extends StatelessWidget {
  final bool condition;
  final String text;
  var onPressedConditionTrue;

  ElevatedButtonWidget(
      {required this.condition,
      required this.text,
      required this.onPressedConditionTrue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: space_4),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(space_6),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  condition ? activeButtonColor : deactiveButtonColor,
            ),
            child: Container(
              height: space_8,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: white,
                      fontSize: size_8,
                      fontWeight: mediumBoldWeight),
                ),
              ),
            ),
            onPressed: condition
                ? onPressedConditionTrue
                : null,
          )),
    );
  }
}
