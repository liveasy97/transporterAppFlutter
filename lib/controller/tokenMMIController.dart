//MMI = Map My India

import 'package:get/get.dart';

class TokenMMIController extends GetxController{
  RxString tokenMMI = "".obs;
  void updateTokenMMI(String newValue){
    tokenMMI.value = newValue;
  }
}