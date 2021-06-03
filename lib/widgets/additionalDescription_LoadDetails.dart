import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

class AdditionalDescriptionLoadDetails extends StatelessWidget {
  String? comment;

  AdditionalDescriptionLoadDetails(this.comment);
  @override
  Widget build(BuildContext context) {
    if(comment!.length==0||comment!.isEmpty)comment="No Comments";
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Additional Description",
          style: TextStyle(
              fontWeight: mediumBoldWeight, fontSize: size_7),
        ),
        SizedBox(
          height: space_2,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
              space_1, space_1, space_2, space_2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(space_1+3),
              border: Border.all(color: solidLineColor)),
          child: Text(
            "$comment",
            style: TextStyle(
                fontWeight: normalWeight, fontSize: size_6),
          ),
        ),
      ],
    );
  }
}
