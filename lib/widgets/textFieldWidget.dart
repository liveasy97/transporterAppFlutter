import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/widgets/cancelIconWidget.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final dynamic onChanged;
  final String hintText;

  TextFieldWidget({
    required this.controller,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: liveasyBlackColor, width: 0.8),
        borderRadius: BorderRadius.circular(30),
        color: widgetBackGroundColor,
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        autofocus: true,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
          suffixIcon: IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: CancelIconWidget()),
        ),
      ),
    );
  }
}
