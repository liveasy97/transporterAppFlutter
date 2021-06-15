import 'package:get/get.dart';

class TransporterIdController extends GetxController{
  RxString transporterId = "".obs;
  void updateTransporterId(String newValue){
    transporterId.value = newValue;
  }
  RxBool transporterApproved = false.obs;
  void updateTransporterApproved(bool newValue){
    transporterApproved.value = newValue;
  }
  RxBool companyApproved = false.obs;
  void updateCompanyApproved(bool newValue){
    companyApproved.value = newValue;
  }
  RxString mobileNum = "".obs;
  void updateMobileNum(String newValue){
    mobileNum.value = newValue;
  }
}