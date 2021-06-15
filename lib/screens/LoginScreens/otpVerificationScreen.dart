import 'dart:ui';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/hudController.dart';
import 'package:liveasy/controller/timerController.dart';
import 'package:liveasy/functions/runTransporterApiPost.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/screens/navigationScreen.dart';
import 'package:liveasy/widgets/otpInputField.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liveasy/widgets/curves.dart';
import 'package:liveasy/widgets/cardTemplate.dart';
import 'package:liveasy/functions/authFunctions.dart';
import 'package:provider/provider.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/fontSize.dart';

class NewOTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  NewOTPVerificationScreen(this.phoneNumber);

  @override
  _NewOTPVerificationScreenState createState() =>
      _NewOTPVerificationScreenState();
}

class _NewOTPVerificationScreenState extends State<NewOTPVerificationScreen> {
//--------------------------------------------------------------------------------------------------------------------

//objects
  AuthService authService = AuthService();

  //keys
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //variables
  String _verificationCode = '';
  late int _forceResendingToken = 0;


  //controllers

  TimerController timerController = Get.put(TimerController());
  HudController hudController = Get.put(HudController());

  //--------------------------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Scaffold(
        key: _scaffoldKey,
        body: Obx(
          () => ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            inAsyncCall: hudController.showHud.value,
            child: SingleChildScrollView(
              child: Center(
                child: Stack(
                  children: [
                    OrangeCurve(),
                    GreenCurve(),
                    CardTemplate(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            space_4, space_10, space_3, space_0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  space_2, space_0, space_0, space_2),
                              child: Text(
                                'Enter OTP',
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontWeight: boldWeight,
                                  fontSize: size_12,
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: space_2),
                                child: Text(
                                    'OTP send to +91${widget.phoneNumber}')),
                            OTPInputField(),
                            Row(
                              children: [
                                Container(
                                  child: TextButton(
                                      onPressed:
                                          timerController.timeOnTimer.value > 0
                                              ? null
                                              : () {
                                                  timerController.startTimer();
                                                  hudController.updateHud(true);
                                                  _verifyPhoneNumber();
                                                },
                                      child: Text(
                                        'Resend OTP',
                                        style: TextStyle(
                                          letterSpacing: 0.5,
                                          color: timerController.resendButton.value ? navygreen : unselectedGrey,
                                          decoration: TextDecoration.underline,
                                        ),
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      space_4, space_0, space_0, space_0),
                                  child: Row(
                                    children: [
                                      Obx(
                                        () => Text(
                                          'Remaining time: ${timerController.timeOnTimer}',
                                          style: TextStyle(color: navygreen),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.70,
                                  height: space_9,
                                  margin: EdgeInsets.fromLTRB(
                                      space_8, space_4, space_8, space_0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(space_10),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              providerData.buttonColor,
                                        ),
                                        child: Text(
                                          'Confirm',
                                          style: TextStyle(
                                            color: white,
                                          ),
                                        ),
                                        onPressed: providerData
                                                .inputControllerLengthCheck
                                            ? () {
                                                hudController.updateHud(true);
                                                // timerController.cancelTimer();
                                                authService.manualVerification(
                                                    smsCode:
                                                        providerData.smsCode,
                                                    verificationId:
                                                        _verificationCode);
                                                providerData.clearall();
                                              }
                                            : null),
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Want to change number',
                                      style: TextStyle(
                                        color: navygreen,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    timerController.startTimer();
    // hudController.updateHud(true);
    _verifyPhoneNumber();
  }

  void _verifyPhoneNumber() async {
    // try {
    print('in verify phone');
    print(widget.phoneNumber);
    print(widget.phoneNumber.runtimeType);
    await FirebaseAuth.instance.verifyPhoneNumber(
        //this value changes runtime
        forceResendingToken: _forceResendingToken,
        phoneNumber: '+91${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('in verification completed');
              await FirebaseAuth.instance.signInWithCredential(credential);
          timerController.cancelTimer();
          hudController.updateHud(false);
          runTransporterApiPost(mobileNum: widget.phoneNumber);
          Get.offAll(() => NavigationScreen());
        },
        verificationFailed: (FirebaseAuthException e) {
          print('in verification failed');
          hudController.updateHud(false);
          print(e.message);
        },
        codeSent: (String? verificationId, int? resendToken) {
          setState(() {
            print('in codesent');
            _forceResendingToken = resendToken!;
            print(_forceResendingToken);
            _verificationCode = verificationId!;
            print(_verificationCode);
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('in auto retrieval timeout');
          if (mounted) {
            hudController.updateHud(false);
            timerController.cancelTimer();
            setState(() {
              _verificationCode = verificationId;
            });
          }
        },
        timeout: Duration(seconds: 60));
    // } catch (e) {
    //   hudController.updateHud(false);
    // }
  }
} // class end
