import 'package:geolocator/geolocator.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/controller/hudController.dart';
import 'package:liveasy/screens/LoginScreens/locationDisabledScreen.dart';
import 'package:liveasy/screens/LoginScreens/otpVerificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/widgets/curves.dart';
import 'package:get/get.dart';
import 'package:liveasy/widgets/cardTemplate.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:provider/provider.dart';
import 'package:liveasy/widgets/phoneNumberTextField.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/constants/color.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  HudController hudController = Get.put(HudController());

  void initState() {
    super.initState();
    hudController.updateHud(
        false); // so that if user press the back button in between verification verifying stop
    getLocationPermission();
  }

  PermissionStatus? permission1;
  Position? userPosition;

  getLocationPermission() async {
    await LocationPermissions().requestPermissions();
    permission1 = await LocationPermissions().checkPermissionStatus();
    // userPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // final coordinates = new Coordinates(userPosition!.latitude, userPosition!.longitude);
    // var addresses =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // var first = addresses.first;
    // print(first.addressLine);
  }

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    
    if (permission1 == PermissionStatus.denied ||
        permission1 == PermissionStatus.restricted) {
      return LocationDisabledScreen();
    }
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      body: Stack(
        children: [
          // OrangeCurve(),
          // GreenCurve(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: bidBackground,
          ),

          Positioned(
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: space_8, bottom: space_12),
                  child: Container(
                    width: space_34,
                    height: space_8,
                    child: Image(
                      image: AssetImage("assets/icons/Liveasy.png"),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius_3),
                          topRight: Radius.circular(radius_3))),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: space_7),
                        child: Text(
                          'Welcome To Liveasy',
                          style: TextStyle(
                            fontSize: size_10,
                            fontWeight: boldWeight,
                            color: black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            space_0, space_3, space_0, space_6),
                        child: Text(
                          'A 6-digit OTP will be sent via SMS to verify \n your number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: regularWeight,
                            fontSize: size_6,
                            color: lightNavyBlue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: space_9, right: space_9),
                        child: Form(
                          key: _formKey,
                          child: PhoneNumberTextField(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: space_9,
                        margin: EdgeInsets.fromLTRB(
                            space_8, space_11, space_8, space_0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(space_10),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: providerData.buttonColor,
                              ),
                              child: Text(
                                'Send OTP',
                                style: TextStyle(
                                  color: white,
                                ),
                              ),
                              onPressed: providerData.inputControllerLengthCheck
                                  ? () {
                                      Get.to(() => NewOTPVerificationScreen(
                                          providerData.phoneController));

                                      //null safety error here , needs to be resolved
                                      // if (_formKey.currentState!.validate()) {
                                      //   Get.to(() => NewOTPVerificationScreen(
                                      //       providerData.phoneController));

                                      providerData.clearAll();
                                    } // if

                                  : () {}),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
