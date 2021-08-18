import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/buttons/CancelButttonBidDialogBox.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog extends StatefulWidget {
  const PermissionDialog({Key? key}) : super(key: key);

  @override
  _PermissionDialogState createState() => _PermissionDialogState();
}

class _PermissionDialogState extends State<PermissionDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular((radius_2 - 2)),
      ),
      title: Text(
        "Camera Permission",
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
            "This app needs camera access to take pictures for upload user documents",
            style: TextStyle(
                color: loadingPointTextColor,
                fontSize: size_8,
                fontWeight: normalWeight
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
                        backgroundColor: MaterialStateProperty.all<Color>(bidBackground),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radius_4)
                            )
                        )
                    ),
                    onPressed: () => {openAppSettings(), Navigator.pop(context)},
                    child: Text(
                      "Settings",
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