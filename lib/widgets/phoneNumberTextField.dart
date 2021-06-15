import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class PhoneNumberTextField extends StatefulWidget {

  @override
  _PhoneNumberTextFieldState createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    ProviderData providerData = Provider.of<ProviderData>(context);
    
    return TextFormField(
      onChanged: (_controller) {
        if (_controller.length == 10) {
          providerData.updateInputControllerLengthCheck(true);
          providerData.updateButtonColor(activeButtonColor);
        } 
        else {
          providerData.updateInputControllerLengthCheck(false);
          providerData
              .updateButtonColor(deactiveButtonColor);
        }
        providerData.updatePhoneController(_controller);
      },
      maxLength: 10,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]')),
      ],
      controller: _controller,
      validator: (value) =>
          value!.length == 10 ? null : 'Enter a Correct Phone Number',
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: Padding(
            padding: EdgeInsets.all(space_3),
            child: Text(
              '+91 ',
              style: TextStyle(
                color: grey,
                fontSize: space_3,
              ),
            )),
        filled: true,
        fillColor: backgroundGrey,
        hintText: 'Enter Phone Number',
        hintStyle: TextStyle(color: grey),
        suffixIcon: Icon(
          Icons.call_outlined,
          color: grey,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(space_4),
          borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: backgroundGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(space_4),
          borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: backgroundGrey),
        ),
      ),
    );
  }
}
