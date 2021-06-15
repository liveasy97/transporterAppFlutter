/*import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/controller/truckTypeButtonController.dart';
import 'package:get/get.dart';


class TruckTypeButtonTemplate extends StatefulWidget {
  final String text ;
  final String value ;
  // final id;

  TruckTypeButtonTemplate({required this.value , required this.text});

  @override
  _TruckTypeButtonTemplateState createState() => _TruckTypeButtonTemplateState();
}

class _TruckTypeButtonTemplateState extends State<TruckTypeButtonTemplate> {
  bool selected = false;
  TruckTypeButtonController truckTypeButtonController = TruckTypeButtonController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
        style: ButtonStyle(
            backgroundColor:Obx( () =>
              truckTypeButtonController.id.value == widget.value
                  ? MaterialStateProperty.all(darkBlueColor) : MaterialStateProperty.all(whiteBackgroundColor),
            ),

            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                )
            )
        ),
        child: Text(
            '${widget.text}',
              style: TextStyle(
                fontSize: size_7,
                color: selected ? white : black
              ),),
        onPressed: (){

          truckTypeButtonController.updateButtonState(widget.value);
          // setState(() {
          //   selected = true;
          //   truckTypeButtonController.updateButtonState(false);
          // });
        },
      ),
    );
  }
}*/
