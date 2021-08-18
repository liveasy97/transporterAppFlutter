import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:shimmer/shimmer.dart';

class TruckLoadingLongWidgets extends StatelessWidget {
  const TruckLoadingLongWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget(),
        SizedBox(
          height: space_2,
        ),
        widget(),
        SizedBox(
          height: space_2,
        ),
        widget(),
      ],
    );
  }

  Card widget() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(space_2),
        child: Shimmer.fromColors(
          highlightColor: greyishWhiteColor,
          baseColor: lightGrey,
          child: Container(
            width: (space_20 + space_40),
            height: space_12,
            color: lightGrey,
          ),
        ),
      ),
    );
  }
}
