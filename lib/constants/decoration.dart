import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';

  final BoxDecoration pinPutDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
          offset: Offset.fromDirection(1), color: grey, blurRadius: 2),
    ],
    borderRadius: BorderRadius.circular(space_2),
    color: white,
    border: Border.all(
      color: white,
    ),
  );