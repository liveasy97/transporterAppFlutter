import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:liveasy/controller/hudController.dart';
import 'package:liveasy/controller/timerController.dart';
import 'package:liveasy/screens/navigationScreen.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/screens/LoginScreens/loginScreen.dart';

class AuthService {

  HudController hudController = Get.put(HudController());
  TimerController timerController = Get.put(TimerController());

  Future signOut() async {
    try{
      Get.to(() => LoginScreen());
      return FirebaseAuth.instance.signOut();
      }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  void manualVerification({String? verificationId, String? smsCode}) async {
    print('verificationId in manual func: $verificationId');
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationId!, smsCode: smsCode!))
          .then((value) async {
        if (value.user != null) {
          print('hud false due to try in manual verification');
          // hudController.updateHudController(false);
          hudController.updateHud(false);
          timerController.cancelTimer();
          Get.offAll(() => NavigationScreen());
        }
      });
    } catch (e) {
      // FocusScope.of(context).unfocus();

      print('hud false due to catch in manual verification');

      hudController.updateHud(false);
      // Get.to(() => NewLoginScreen());

      Get.snackbar('Invalid Otp', 'Please Enter the correct OTP',
          colorText: white, backgroundColor: black_87);
    }


  }
}
