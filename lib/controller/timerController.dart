import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  RxInt timeOnTimer = 60.obs;
  RxBool resendButton = false.obs;

  Timer? timer;

  void startTimer() async {
    timeOnTimer = 60.obs;

    if (timer != null) {
      cancelTimer();
    }

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeOnTimer > 0) {
        timeOnTimer--;
      } else {
        resendButton = true.obs;
        cancelTimer();

      }
    });
  }

  void cancelTimer() {
    timer!.cancel();
  }
}
