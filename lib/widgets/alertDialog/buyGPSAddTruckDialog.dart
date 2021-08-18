import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/truckApis/truckApiCalls.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/widgets/alertDialog/CompletedDialog.dart';
import 'package:liveasy/widgets/alertDialog/sameTruckAlertDialogBox.dart';
import 'package:liveasy/widgets/buttons/CancelButttonBidDialogBox.dart';
import 'package:provider/provider.dart';

class BuyGPSAddTruckDialog extends StatefulWidget {
  const BuyGPSAddTruckDialog({Key? key}) : super(key: key);

  @override
  _BuyGPSAddTruckDialogState createState() => _BuyGPSAddTruckDialogState();
}

class _BuyGPSAddTruckDialogState extends State<BuyGPSAddTruckDialog> {
  TextEditingController _controller = TextEditingController();
  String? truckId;
  TruckApiCalls truckApiCalls = TruckApiCalls();
  bool isDisable = false;
  bool? loading = false;
  RegExp truckNoRegex = RegExp(
      r"^[A-Za-z]{2}[ -/]{0,1}[0-9]{1,2}[ -/]{0,1}(?:[A-Za-z]{0,1})[ -/]{0,1}[A-Za-z]{0,2}[ -/]{0,1}[0-9]{4}$");

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular((radius_2 - 2)),
      ),
      title: Text(
          "Add Truck",
        style: TextStyle(
          color: bidBackground,
          fontSize: size_9,
          fontWeight: mediumBoldWeight
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Enter truck number",
            style: TextStyle(
              color: loadingPointTextColor,
              fontSize: size_8,
              fontWeight: normalWeight
            ),
          ),
          SizedBox(
            height: space_1,
          ),
          Container(
            height: space_7+2,
            padding: EdgeInsets.only(
              left: space_3,
              right: space_3,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_4+2),
                border: Border.all(color: darkGreyColor)
            ),
            child: TextFormField(
              onChanged: (value) {
                if (_controller.text != value.toUpperCase())
                  _controller.value = _controller.value
                      .copyWith(text: value.toUpperCase());
                if (truckNoRegex.hasMatch(value) && value.length > 9) {
                  print("It is correct enable");
                  providerData.updateResetActive(true);
                } else {
                  print("It is wrong disable");
                  providerData.updateResetActive(false);
                }
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z0-9]")),
              ],
              textCapitalization: TextCapitalization.characters,
              controller: _controller,
              // textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Eg: UP 22 GK 2222',
                hintStyle: TextStyle(
                  color: textLightColor,
                  fontSize: size_7,
                  fontWeight: boldWeight,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: liveasyBlackColor,
                fontSize: size_7,
                fontWeight: regularWeight
              ),
            ),
          ),
          SizedBox(
            height: space_2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: (space_6 + 1),
                width: space_16,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(isDisable
                        ? bidBackground
                        : providerData.resetActive
                        ? bidBackground
                        : solidLineColor
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius_4)
                      )
                    )
                  ),
                    onPressed: providerData.resetActive
                        ? () async {
                      setState(() {
                        loading = true;
                      });
                      truckId = await truckApiCalls.postTruckData(truckNo: _controller.text);
                      if (truckId != null) {
                        setState(() {
                          loading = false;
                        });
                        providerData.updateResetActive(false);
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) => completedDialog(
                              upperDialogText: "You’ve added truck successfully!",
                              lowerDialogText: "",
                            ));
                      } else {
                        setState(() {
                          loading = false;
                        });
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return SameTruckAlertDialogBox();
                            });
                      }
                    }
                        : null,
                    child: Text(
                      "Add",
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: (size_6 + 1),
                        fontWeight: mediumBoldWeight
                      ),
                    )
                ),
              ),
              SizedBox(
                width: space_1,
              ),
              CancelButtonBidDialogBox()
            ],
          )
        ],
      ),
    );
  }
}
