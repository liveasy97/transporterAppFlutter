import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';

// ignore: must_be_immutable
class ProfilePhotoWidget extends StatelessWidget {
  var providerData;

  ProfilePhotoWidget({this.providerData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      width: 115,
      decoration: providerData.profilePhotoFile != null
          ? BoxDecoration(
              color: white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: grey,
                  blurRadius: 5.0,
                ),
              ],
              image: DecorationImage(
                  image: Image.file(providerData.profilePhotoFile).image,
                  fit: BoxFit.fill),
            )
          : BoxDecoration(
              color: white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: grey,
                  blurRadius: 5.0,
                ),
              ],
              image: DecorationImage(
                image: AssetImage("assets/icons/accountIconFilled.png"),
              ),
            ),
      child: providerData.profilePhotoFile == null
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.fromLTRB(75, 0, 0, 5),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    height: space_4,
                    width: space_4,
                    child: Center(
                      child: Icon(
                        Icons.add_box_rounded,
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: Text(
                "Tap to refresh",
                style: TextStyle(fontSize: size_7, color: truckGreen),
              ),
            ),
    );
  }
}
