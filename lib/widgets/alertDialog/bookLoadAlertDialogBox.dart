import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/SelectedDriverController.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/loadOnGoingData.dart';
import 'package:liveasy/functions/truckApis/truckApiCalls.dart';
import 'package:liveasy/models/biddingModel.dart';
import 'package:liveasy/models/driverModel.dart';
import 'package:liveasy/models/loadDetailsScreenModel.dart';
import 'package:liveasy/models/truckModel.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/TruckScreens/AddNewTruck/truckNumberRegistration.dart';
import 'package:liveasy/widgets/buttons/confirmButtonSendRequest.dart';
import 'package:liveasy/widgets/buttons/CancelSelectedTruckDriverButton.dart';
import 'package:provider/provider.dart';
import 'addDriverAlertDialog.dart';

// ignore: must_be_immutable
class BookLoadAlertDialogBox extends StatefulWidget {
  List? truckModelList;
  List? driverModelList;
  LoadDetailsScreenModel? loadDetailsScreenModel;
  BiddingModel? biddingModel;
  bool? directBooking;
  String? postLoadId;

  BookLoadAlertDialogBox(
      {this.truckModelList,
      this.postLoadId,
      this.driverModelList,
      this.loadDetailsScreenModel,
      this.biddingModel,
      required this.directBooking});

  @override
  _BookLoadAlertDialogBoxState createState() => _BookLoadAlertDialogBoxState();
}

class _BookLoadAlertDialogBoxState extends State<BookLoadAlertDialogBox> {
  String? selectedTruck;
  String? selectedDriver;
  String? selectedDriverName;

  TransporterIdController transporterIdController = Get.find();

  TruckApiCalls truckApiCalls = TruckApiCalls();

  // List? truckDropDownList ;

  late TruckModel truckModel = TruckModel(
      truckApproved: false, truckId: 'Add new Truck', truckNo: 'Add new Truck');
  late DriverModel driverModel = DriverModel(
      driverId: 'Add new Driver', driverName: 'Add new Driver', phoneNum: '');
  late List? driverList = [];
  late List? truckList = [];
  List<DropdownMenuItem<String>> dropDownList = [];
  List<DropdownMenuItem<String>> dropDownListT = [];
  SelectedDriverController selectedDriverController =
      Get.find<SelectedDriverController>();

  getDriverList() async {
    List temp;
    temp = await driverApiCalls.getDriversByTransporterId();
    setState(() {
      driverList = temp;
      // print(driverList[0]);
    });
    for (var instance in driverList!) {
      bool instanceAlreadyAdded = false;
      for (var dropDown in dropDownList) {
        if (dropDown.value == instance.driverId) {
          instanceAlreadyAdded = true;
          break;
        }
      }
      if (!instanceAlreadyAdded) {
        dropDownList.insert(
            0,
            DropdownMenuItem<String>(
              value: instance.driverId,
              child: Text('${instance.driverName}-${instance.phoneNum}'),
            ));
      }
    }

    // bool addNewDriverAlreadyAdded = false;
    // for (var dropDown in dropDownList) {
    //   if (dropDown.value == 'e') {
    //     addNewDriverAlreadyAdded = true;
    //     break;
    //   }
    // }
    // if (!addNewDriverAlreadyAdded) {
    //   dropDownList.add(DropdownMenuItem(
    //     value: 'e',
    //     child: Expanded(
    //       child: Container(
    //         width: 400,
    //         child: TextButton(
    //           onPressed: () {
    //             showDialog(
    //                 context: context,
    //                 builder: (context) => AddDriverAlertDialog());
    //           },
    //           child: Text('Add New Driver'),
    //         ),
    //       ),
    //     ),
    //   ));
    // }
    // selectedDriverController.updateSelectedDriverController(
    //     '${driverList[0].driverName}-${driverList[0].phoneNum}');
    // for (var instance in driverList[0].d) {
    //
    //   print('${instance.driverName}-${instance.phoneNum}');
    // }
    // print("driver list driver name${driverList[0].driverName}");
  }

  getTruckList() async {
    List temp;
    temp = await truckApiCalls.getTruckData();
    setState(() {
      truckList = temp;
    });
    for (var instance in truckList!) {
      bool instanceAlreadyAdded = false;
      for (var dropDown in dropDownListT) {
        if (dropDown.value == instance.truckId) {
          instanceAlreadyAdded = true;
          break;
        }
      }
      if (!instanceAlreadyAdded) {
        dropDownListT.insert(
            0,
            DropdownMenuItem<String>(
              value: instance.truckId,
              child: Text('${instance.truckNo}'),
            ));
      }
    }

    // bool addNewTruckAlreadyAdded = false;
    // for (var dropDown in dropDownListT) {
    //   if (dropDown.value == '') {
    //     addNewTruckAlreadyAdded = true;
    //     break;
    //   }
    // }
    //
    // dropDownListT.add(DropdownMenuItem(
    //   value: '',
    //   child: Expanded(
    //     child: Container(
    //       width: 400,
    //       child: TextButton(
    //         onPressed: () {
    //           // providerData.updateIsAddTruckSrcDropDown(true);
    //           Navigator.pop(context);
    //           Get.to(() => AddNewTruck());
    //         },
    //         child: Text('Add New Truck'),
    //       ),
    //     ),
    //   ),
    // ));
  }

  void autoAddDriver() {
    getDriverList();
    getTruckList();
    // if (selectedDriverController.newDriverAddedBook.value) {
    //   selectedDriver = selectedDriverController.selectedDriverBook.value;
    //   selectedDriverController.updateNewDriverAddedBookController(false);
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDriverList();
    getTruckList();
  }
  refresh() {
    setState(() {
      var page= ModalRoute.of(context)!.settings.name;
      Get.to(page);
    });
  }
  @override
  Widget build(BuildContext context) {
    selectedDriverController.updateFromTruck(false);
    selectedDriverController.updateFromBook(true);
    // selectedDriver = dropDownList![0];
    ProviderData providerData = Provider.of<ProviderData>(context);

    widget.truckModelList!.add(truckModel);

    widget.driverModelList!.add(driverModel);

    // print(
    //     "bookLoadAlertDialog.dart ${selectedDriverController.newDriverAddedBook.value}");
    autoAddDriver();
    // for (var i in widget.driverModelList!) {
    //   print(i.driverName);
    // }
    // print('driver list driver name $selectedDriver');

    return AlertDialog(
      contentPadding: EdgeInsets.all(space_1),
      insetPadding: EdgeInsets.only(
        left: space_4,
        right: space_4,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: space_2 + 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: space_2),
                child: Text(
                  "Select a Truck",
                  style: TextStyle(fontSize: size_9, fontWeight: normalWeight),
                ),
              ),
              TextButton(
                onPressed: () {
                  // providerData.updateIsAddTruckSrcDropDown(true);
                  Navigator.pop(context);
                  Get.to(() => AddNewTruck());
                },
                child: Text('Add New Truck'),
              ),
            ],
          ),
          // SizedBox(
          //   height: space_2,
          // ),
          Container(
            height: space_7 + 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_4 + 2),
                border: Border.all(color: darkGreyColor)),
            child: Padding(
              padding: EdgeInsets.only(
                left: space_2 - 2,
                right: space_2 - 2,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  isDense: true,
                  isExpanded: true,
                  focusColor: Colors.blue,
                  hint: Text('Truck number'),
                  value: selectedTruck,
                  icon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: darkBlueColor,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: white,
                      )),
                  onChanged: (String? newValue) {
                    providerData.updateDropDownValue(newValue);
                    setState(() {
                      selectedTruck = newValue!;
                      for (TruckModel truckModel in widget.truckModelList!) {
                        if (truckModel.truckId == selectedTruck) {
                          if (truckModel.driverId != null) {
                            for (var dropDown in dropDownList) {
                              if (dropDown.value == truckModel.driverId) {
                                selectedDriver = truckModel.driverId;
                                break;
                              } else {
                                selectedDriver = null;
                                selectedDriverName = null;
                              }
                            }

                            for (DriverModel driverModel
                                in widget.driverModelList!) {
                              if (driverModel.driverId == selectedDriver) {
                                selectedDriverName = driverModel.driverName;
                              }
                            }
                          }
                          //executed if truck doesn't have a driver
                          else {
                            selectedDriver = null;
                            selectedDriverName = null;
                          }
                          break;
                        } //first if
                      }
                    });
                  },
                  items: dropDownListT,
                ),
              ),
            ),
          ),
          SizedBox(
            height: space_2 + 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select a Driver",
                style: TextStyle(fontSize: size_9, fontWeight: normalWeight),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AddDriverAlertDialog(notifyParent: refresh));
                },
                child: Text('Add New Driver'),
              ),
            ],
          ),
          // SizedBox(
          //   height: space_2,
          // ),
          Container(
            height: space_7 + 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_4 + 2),
                border: Border.all(color: Color(0xFF878787))),
            child: Padding(
              padding: EdgeInsets.only(
                left: space_2 - 2,
                right: space_2 - 2,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  isDense: true,
                  isExpanded: true,
                  focusColor: Colors.blue,
                  hint: Text('Driver Name-Number'),
                  value: selectedDriver,
                  icon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: darkBlueColor,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: white,
                      )),
                  onChanged: (String? newValue) {
                    providerData.updateDropDownValue(newValue);
                    setState(() {
                      selectedDriver = newValue!;
                    });
                  },
                  items: dropDownList,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: space_11, bottom: space_4 + 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.loadDetailsScreenModel != null
                  ? ConfirmButtonSendRequest(
                      selectedDriverName: selectedDriver,
                      loadDetailsScreenModel: widget.loadDetailsScreenModel,
                      truckId: selectedTruck,
                      directBooking: true,
                    )
                  : ConfirmButtonSendRequest(
                      selectedDriverName: selectedDriver,
                      directBooking: false,
                      postLoadId: widget.postLoadId,
                      truckId: selectedTruck,
                      biddingModel: widget.biddingModel,
                    ),
              CancelSelectedTruckDriverButton(
                driverModelList: widget.driverModelList,
                truckModelList: widget.truckModelList,
              )
            ],
          ),
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
      ),
    );
  }
}
