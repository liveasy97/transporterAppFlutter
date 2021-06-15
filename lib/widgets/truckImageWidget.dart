import 'package:flutter/material.dart';

class TruckImageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(top: 14),
      child: Image(
        fit: BoxFit.cover,
        height: 138.18,
        width: 117,
        image: AssetImage("assets/images/truckLoadImage.png"),
      ),
    );
  }
}
