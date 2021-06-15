import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';

// ignore: must_be_immutable
class ApplyButton extends StatelessWidget {

  dynamic onPressedFunction;

  ApplyButton({required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.053,
      width : MediaQuery.of(context).size.width * 0.3,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(darkBlueColor),
        ),
        onPressed:onPressedFunction,
        child: Text(
          'Apply',
          style: TextStyle(
            letterSpacing: 0.7,
            fontWeight: FontWeight.w400,
            color: white,
            fontSize: space_3,
          ),
        ),
      ),
    );
  }
}
