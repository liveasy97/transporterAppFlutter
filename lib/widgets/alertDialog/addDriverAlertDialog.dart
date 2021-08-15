import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/getDriverDetailsFromDriverApi.dart';
import 'package:liveasy/functions/getTruckDetailsFromTruckApi.dart';
import 'package:liveasy/functions/loadOnGoingDeliveredData.dart';
import 'package:liveasy/models/responseModel.dart';
import 'package:liveasy/widgets/buttons/addButton.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:liveasy/widgets/buttons/cancelButtonForAddNewDriver.dart';

// ignore: must_be_immutable
class AddDriverAlertDialog extends StatefulWidget {
  @override
  _AddDriverAlertDialogState createState() => _AddDriverAlertDialogState();
}

class _AddDriverAlertDialogState extends State<AddDriverAlertDialog> {
  TextEditingController driverNameController = TextEditingController();
  TextEditingController driverNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Driver’s Name",
            style: TextStyle(
                fontSize: size_9,
                fontWeight: normalWeight,
                color: liveasyBlackColor),
          ),
          SizedBox(
            height: space_2,
          ),
          Container(
            height: space_7 + 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_4 + 2),
                border: Border.all(color: darkGreyColor)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: space_2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: driverNameController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "Type here",
                        hintStyle: TextStyle(
                            color: textLightColor,
                            fontSize: size_8,
                            fontWeight: regularWeight),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        print(driverNameController.text);
                        print(driverNumberController.text);

                        // if (await Permission.contacts.request().isGranted) {

                        final PhoneContact contact =
                            await FlutterContactPicker.pickPhoneContact(
                                askForPermission: true);
                        print("picked contact: $contact");

                        setState(() {
                          String contactName = contact.fullName.toString();
                          driverNameController =
                              TextEditingController(text: contactName);

                          String contactNumber =
                              contact.phoneNumber!.number!.contains("+91")
                                  ? contact.phoneNumber!.number!
                                      .replaceRange(0, 3, "")
                                      .replaceAll(new RegExp(r"\D"), "")
                                  : contact.phoneNumber!.number!.toString();

                          driverNumberController =
                              TextEditingController(text: contactNumber);
                        });
                      },
                      child: Image(
                        image:
                            AssetImage("assets/icons/addFromPhoneBookIcon.png"),
                        height: space_5 + 2,
                        width: space_5 + 2,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: space_2 + 2,
          ),
          Text(
            "Driver's Number",
            style: TextStyle(
                fontSize: size_9,
                fontWeight: normalWeight,
                color: liveasyBlackColor),
          ),
          SizedBox(
            height: space_2,
          ),
          Container(
            height: space_7 + 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_4 + 2),
                border: Border.all(color: darkGreyColor)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: space_2),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: driverNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Type here",
                  hintStyle: TextStyle(
                      color: textLightColor,
                      fontSize: size_8,
                      fontWeight: regularWeight),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AddButton(
              name: driverNameController.text,
              number: driverNumberController.text,
              onTap: () async {
                if (driverNumberController.text.length == 10 &&
                    (driverNumberController.text
                        .startsWith(RegExp(r'[6-9]')))) {
                  TransporterIdController tIdController =
                      Get.find<TransporterIdController>();
                  String transporterId = '${tIdController.transporterId}';
                  ResponseModel? response = await driverApiCalls.postDriverApi(
                      driverNameController.text,
                      driverNumberController.text,
                      transporterId);
                  if (response != null) {
                    if (response.statusCode == 201 && response.id != null) {
                      // driver added successfully
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      //For Book Now Alert Dialog
                      await getTruckDetailsFromTruckApi(context);
                      await getDriverDetailsFromDriverApi(context);
                    } else {
                      // most likely user trying to add same number again
                      Get.defaultDialog(
                        content: Container(
                          child: Column(
                            children: [
                              Text("Conflict !"),
                              Text("${response.message}")
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    //response is null so error with api
                    Get.defaultDialog(
                      content: Container(
                        child: Column(
                          children: [
                            Text("Oops!! Error!"),
                            Text("Please Try Again Later")
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  //user entered an invalid mobile number
                  Get.defaultDialog(
                    content: Container(
                      child: Column(
                        children: [
                          Text("Error!"),
                          Text("Enter a valid 10 digit number")
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            CancelButtonForAddNewDriver()
          ],
        )
      ],
      contentPadding:
          EdgeInsets.symmetric(horizontal: space_3, vertical: space_4),
      actionsPadding: EdgeInsets.only(top: space_8, bottom: space_3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
      ),
      insetPadding: EdgeInsets.only(left: space_4, right: space_4),
    );
  }
}
