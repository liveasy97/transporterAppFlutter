import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/tokenMMIController.dart';
import 'package:liveasy/functions/autoFillMMI.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/findLoadScreen.dart';
import 'package:liveasy/widgets/autoFillDataDisplayCard.dart';
import 'package:liveasy/widgets/buttons/backButtonWidget.dart';
import 'package:liveasy/widgets/textFieldWidget.dart';
import 'package:provider/provider.dart';

class CityNameInputScreen extends StatefulWidget {
  final String valueType;

  CityNameInputScreen(this.valueType);

  @override
  _CityNameInputScreenState createState() => _CityNameInputScreenState();
}

class _CityNameInputScreenState extends State<CityNameInputScreen> {
  TokenMMIController tokenMMIController = Get.put(TokenMMIController());
  var locationCard;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double keyboardLength = MediaQuery.of(context).viewInsets.bottom;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: space_4),
          child: ListView(
            children: [
              SizedBox(
                height: space_6,
              ),
              Container(
                child: Row(
                  children: [
                    BackButtonWidget(),
                    SizedBox(
                      width: space_2,
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        onChanged: (String value) {
                          setState(() {
                            locationCard = fillCityName(value);
                          });
                        },
                        controller: controller,
                        hintText: "Enter City Name",
                      ),
                    ),
                  ],
                ),
              ),
              locationCard == null
                  ? Container()
                  : SizedBox(
                      height: space_4,
                    ),
              locationCard != null
                  ? Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: keyboardLength != 0
                          ? screenHeight - keyboardLength - 130
                          : screenHeight - 130, //TODO: to be modified
                      child: FutureBuilder(
                          future: locationCard,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Container();
                            }
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              reverse: false,
                              padding: EdgeInsets.symmetric(
                                horizontal: space_2,
                              ),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) =>
                                  AutoFillDataDisplayCard(
                                      snapshot.data[index].placeCityName,
                                      snapshot.data[index].placeStateName, () {
                                if (widget.valueType == "Loading Point") {
                                  Provider.of<ProviderData>(context,
                                          listen: false)
                                      .updateLoadingPoint(
                                          city: snapshot
                                              .data[index].placeCityName,
                                          state: snapshot
                                              .data[index].placeStateName);
                                  Get.off(() => FindLoadScreen());
                                } else if (widget.valueType ==
                                    "Unloading Point") {
                                  Provider.of<ProviderData>(context,
                                          listen: false)
                                      .updateUnloadingPoint(
                                          city: snapshot
                                              .data[index].placeCityName,
                                          state: snapshot
                                              .data[index].placeStateName);
                                  Get.off(FindLoadScreen());
                                }
                              }),
                            );
                          }),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
