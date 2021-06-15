import 'package:get/get.dart';

class TruckTypeButtonController extends GetxController{
  RxString id = ''.obs;

  void updateButtonState(String value){
    id.value = value;
  }
}