import 'package:flutter/material.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
class CallButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      width: 80,
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(21, 41, 104, 1)),
          borderRadius: BorderRadius.circular(20)),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.call,
            ),
            Text(
              "Call",
              style: TextStyle(
                  fontSize: size_6 + 1, fontWeight: mediumBoldWeight),
            )
          ],
        ),
      ),
    );
  }
}
