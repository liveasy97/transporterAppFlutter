import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:liveasy/constants/borderWidth.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/constants/color.dart';

class AccountNotVerifiedWidget extends StatelessWidget {
  const AccountNotVerifiedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: space_8,
        padding:
        EdgeInsets.fromLTRB(space_3, space_2-2, space_3, 0),
        margin: EdgeInsets.symmetric(
            horizontal: space_4, vertical: space_4),
        decoration: BoxDecoration(
          color: lightYellow,
          border: Border.all(
              color: darkYellow, width: borderWidth_10),
          borderRadius: BorderRadius.circular(space_1),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline),
                SizedBox(width: space_3,),
                Column(children: [
                  Text("Account details pending!", style: TextStyle(fontSize: size_5, color: black),),
                  Text("Get your account verified to proceed further", style: TextStyle(fontSize: size_4, color: darkGreyColor),)
                ],)
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: darkGreyColor, size: space_2,)
          ],
        ),
      ),
    );
  }
}
