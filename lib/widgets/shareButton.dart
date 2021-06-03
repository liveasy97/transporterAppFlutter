import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:social_share/social_share.dart';

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      SocialShare.shareWhatsapp("Hello World");
    },
      child: Container(
        height: space_8,
        width: (space_10*2)+6,
        decoration: BoxDecoration(
            color: shareButtonColor, borderRadius: BorderRadius.circular(space_6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.center,
                children: [
              Container(
                child: Image(
                  image: AssetImage("assets/icons/shareMiddleIcon.png"),
                  height: 17.0,
                  width: 17.0,
                ),
              ),
              Container(
                child: Image(
                  image: AssetImage("assets/icons/shareOuterIcon.png"),
                  height: 14.01,
                  width: 14.08,
                ),
              ),
              Container(
                child: Image(
                  image: AssetImage("assets/icons/shareInnerIcon.png"),
                  height: 7.94,
                  width: 8.6,
                ),
              ),

            ]),
            SizedBox(width: space_1-0.5,),
            Text(
              "Share",
              style: TextStyle(
                  fontSize: size_8, fontWeight: normalWeight, color: white),
            )
          ],
        ),
      ),
    );
  }
}
