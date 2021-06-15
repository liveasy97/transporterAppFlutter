import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/getImageFromCamera.dart';
import 'package:liveasy/widgets/accountVerification/roundedImageDisplay.dart';

// ignore: must_be_immutable
class CompanyIdInputWidget extends StatelessWidget {
  var providerData;

  CompanyIdInputWidget({this.providerData});

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
                "Company ID Proof",
                style: TextStyle(
                    fontSize: size_8,
                    color: veryDarkGrey,
                    fontWeight: mediumBoldWeight),
              ),
              Text(
                "GST Certificate/Company PAN Card/Visiting\nCard/Rental Agreement",
                style: TextStyle(fontSize: size_6, color: grey),
              ),
              SizedBox(
                height: space_4,
              ),
              Center(
                child: RoundedImageDisplay(
                  text: "",
                  onPressed: () {
                    getImageFromCamera(providerData.updateCompanyIdProofPhoto);
                  },
                  imageFile: providerData.companyIdProofPhotoFile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
