import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/getImageFromCamera.dart';
import 'package:liveasy/widgets/accountVerification/roundedImageDisplay.dart';

// ignore: must_be_immutable
class IdInputWidget extends StatelessWidget {
  var providerData;

  IdInputWidget({this.providerData});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          padding: EdgeInsets.all(space_3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add ID Proof",
                style: TextStyle(
                    fontSize: size_8,
                    color: veryDarkGrey,
                    fontWeight: mediumBoldWeight),
              ),
              Text(
                "(Upload Front and back of PAN Card)",
                style: TextStyle(fontSize: size_6, color: grey),
              ),
              SizedBox(
                height: space_2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedImageDisplay(
                    text: "Pan Front",
                    onPressed: () {
                      getImageFromCamera(providerData.updatePanFrontPhoto);
                    },
                    imageFile: providerData.panFrontPhotoFile,
                  ),
                  RoundedImageDisplay(
                    text: "Pan Back",
                    onPressed: () {
                      getImageFromCamera(providerData.updatePanBackPhoto);
                    },
                    imageFile: providerData.panBackPhotoFile,
                  ),
                ],
              ),
              SizedBox(
                height: space_3,
              ),
              Text(
                "Add Address Proof",
                style: TextStyle(
                  fontWeight: mediumBoldWeight,
                  fontSize: size_8,
                ),
              ),
              Text(
                "(Aadhar Card/Driving License/Ration Card\n/Voter ID/Electricity/GST)",
                style: TextStyle(fontSize: size_6, color: grey),
              ),
              SizedBox(
                height: space_3,
              ),
              Center(
                child: RoundedImageDisplay(
                  text: "",
                  onPressed: () {
                    getImageFromCamera(providerData.updateAddressProofPhoto);
                  },
                  imageFile: providerData.addressProofPhotoFile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
