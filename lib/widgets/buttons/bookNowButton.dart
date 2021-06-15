import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/raidus.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/getDriverDetailsFromDriverApi.dart';
import 'package:liveasy/functions/getTruckNoFromTruckApi.dart';
import 'package:liveasy/widgets/alertDialog/bookNowButtonAlertDialog.dart';
class BookNowButton extends StatefulWidget {
  const BookNowButton({Key? key}) : super(key: key);

  @override
  _BookNowButtonState createState() => _BookNowButtonState();
}

class _BookNowButtonState extends State<BookNowButton> {
@override
  void initState() {
    super.initState();
    getTruckNoFromTruckApi();
    getDriverDetailsFromDriverApi();
  }
  @override

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
         await showInformationDialog(context,truckNoList,driverDetailsList);
        },
        child: Container(
          height: space_8,
          width: (space_16 * 2) + 3,
          decoration: BoxDecoration(
              color: darkBlueColor,
              borderRadius: BorderRadius.circular(radius_6)),
          child: Center(
            child: Text(
              "Book Now",
              style: TextStyle(
                  fontSize: size_8, fontWeight: mediumBoldWeight, color: white),
            ),
          ),
        ));
  }
}
