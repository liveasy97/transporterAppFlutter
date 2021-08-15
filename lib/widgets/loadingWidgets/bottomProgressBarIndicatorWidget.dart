import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';

class bottomProgressBarIndicatorWidget extends StatelessWidget {
  const bottomProgressBarIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularProgressIndicator(color: darkBlueColor,),
    ));
  }
}
