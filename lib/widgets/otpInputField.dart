import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/constants/fontsize.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:liveasy/constants/decoration.dart';
import 'package:flutter/services.dart';

class OTPInputField extends StatefulWidget {
  @override
  _OTPInputFieldState createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  final FocusNode _pinPutFocusNode = FocusNode();
  final TextEditingController _pinPutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Padding(
      padding: EdgeInsets.all(space_2),
      child: PinPut(
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(
              RegExp(r'[0-9]')),
        ],
        fieldsCount: 6,
        textStyle: const TextStyle(fontSize: size_12, color: black),
        eachFieldWidth: space_8,
        eachFieldHeight: space_11,
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration,
        pinAnimationType: PinAnimationType.fade,
        onChanged: (pin) async {
          if (pin.length == 6) {
            providerData.updateInputControllerLengthCheck(true);
            providerData.updateButtonColor(activeButtonColor);
            providerData.updateSmsCode(pin);
          } else {
            providerData.updateInputControllerLengthCheck(false);
            providerData.updateButtonColor(deactiveButtonColor);
          }
        },
      ),
    );
  }
}
