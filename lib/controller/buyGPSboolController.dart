import 'package:get/get.dart';

class BuyGPSHudController extends GetxController {
  RxBool updateButton = false.obs;
  RxBool updateRadioButton = false.obs;
  RxString updateTruckID = ''.obs;

  void updateButtonHud(bool value) {
    updateButton.value = value;
  }

  void updateRadioHud(bool val) {
    updateRadioButton.value = val;
  }

  void updateTruckHud(String value) {
    updateTruckID.value = value;
  }
}
