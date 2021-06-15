import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liveasy/constants/color.dart';

class LoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: SpinKitWave(
            color: loadingWidgetColor,
            size: 60,
          )),
    );
  }
}
