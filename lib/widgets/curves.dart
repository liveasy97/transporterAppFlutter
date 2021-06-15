import 'package:flutter/material.dart';
import 'package:liveasy/functions/curveGenerator.dart';
import 'package:liveasy/constants/color.dart';

class OrangeCurve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OrangeClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color:flagOrange,
        
      ),
    );
  }
}

class GreenCurve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
                clipper: GreenClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: flagGreen,
                ),
              );
  }
}