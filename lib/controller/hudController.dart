import 'package:get/get.dart';

class HudController extends GetxController {
  RxBool showHud = false.obs;

  void updateHud(bool value) {
    showHud.value = value;
  }
}
