import 'dart:io';
import 'package:flutter/material.dart';
import 'package:liveasy/translations/l10n.dart';

//In provider data class variables that will be required across different screens are declared . These variables are updated by defining respective function for them.
//Right now variable declaration and function definition are writing without any specific order but later on change this , there are two options
// 1 Either declare the variables and its functions one below another so that developers immediately know which function updates what variable
// 2 First declare all variables and then declare all functions
//This is effective way for maintenance of code for long term.
//P.S Care should be taken that provider should only be used for updating variables and not processing their values.


// enum class for language selection
enum LanguageItem{
  English,
  Hindi
}


class ProviderData extends ChangeNotifier {
  bool bidButtonSendRequestState = false;

  void updateBidButtonSendRequest(newValue) {
    bidButtonSendRequestState = newValue;
    notifyListeners();
  }

  String? rate1;
  String? unitValue1;

  void updateRate(rate, unitValue) {
    rate1 = rate;
    print('rate in provider : $rate1');
    unitValue1 = unitValue;
    print('unit value in provider $unitValue1');
    notifyListeners();
  }

  List truckNoList = [
    "Add Truck",
  ];

  void updateTruckNoList({required String newValue}) {
    for (int i = 0; i < truckNoList.length; i++) {
      if (truckNoList[i].toString() == newValue.toString()) {
        print("hi truck already added");
        break;
      } else if (i == truckNoList.length - 1) {
        truckNoList.add(newValue);
        break;
      }
    }
    notifyListeners();
  }

  List driverNameList = [
    "Add New Driver",
  ];

  void updateDriverNameList({required String newValue}) {
    for (int i = 0; i < driverNameList.length; i++) {
      if (driverNameList[i].toString() == newValue.toString()) {
        print("hi driver already added");
        break;
      } else if (i == driverNameList.length - 1) {
        driverNameList.add(newValue);
        break;
      }
    }
    notifyListeners();
  }

  int index = 0;
  var selectedTruck;
  var selectedDriver;

  void updateSelectedTruck(String? newValue) {
    selectedTruck = newValue;
    notifyListeners();
  }

  void updateSelectedDriver(String? newValue) {
    selectedDriver = newValue;
    notifyListeners();
  }

  String loadingPointCityFindLoad = "";
  String loadingPointStateFindLoad = "";

  String unloadingPointCityFindLoad = "";
  String unloadingPointStateFindLoad = "";

  String loadingPointCityPostLoad = "";
  String loadingPointStatePostLoad = "";
  String loadingPointPostLoad = "";

  String unloadingPointCityPostLoad = "";
  String unloadingPointStatePostLoad = "";
  String unloadingPointPostLoad = "";

  String bookingDate = "";
  String completedDate = "";

  // variables for accountVerification
  File? profilePhotoFile;
  File? addressProofFrontPhotoFile;
  File? addressProofBackPhotoFile;
  File? panFrontPhotoFile;
  File? companyIdProofPhotoFile;

  String? profilePhoto64;
  String? addressProofFrontPhoto64;
  String? addressProofBackPhoto64;
  String? panFrontPhoto64;
  String? companyIdProofPhoto64;

  // variables for login pages

  bool inputControllerLengthCheck = false;
  dynamic buttonColor = MaterialStateProperty.all<Color>(Colors.grey);
  String smsCode = '';
  String phoneController = '';

  //-------------------------------------

  // variables for add truck pages

  String truckTypeValue = '';
  int passingWeightValue = 0;
  int totalTyresValue = 0;
  int truckLengthValue = 0;
  String driverIdValue = '';
  String truckNumberValue = '';
  String productType = "Choose Product Type";
  int truckNumber = 0;
  int price = 0;
  String unitValue = "";
  String controller = "";
  String controller1 = "";
  String controller2 = "";
  bool perTruck = false;
  bool perTon = false;
  bool otpIsValid = true;

  String truckId = '';

  //variables related to reset button
  bool resetActive = false;

  //variables related to driverApi
  List driverList = [];

  //variables related to orders page
  int upperNavigatorIndex = 0;

  // int rate = 0;
  //
  // void updateRate(value) {
  //   rate = value;
  //   notifyListeners();
  // }

  // bool isAddNewDriver = false;
  // updateIsAddNewDriver(value){
  //   isAddNewDriver = value;
  //   notifyListeners();
  // }
  String postLoadError = "";
  bool loadWidget = true;

  String bidLoadingPoint = '';
  String bidUnloadingPoint = '';

  updateBidEndpoints(loadingPoint, unLoadingPoint) {
    bidLoadingPoint = loadingPoint;
    bidUnloadingPoint = unLoadingPoint;
    notifyListeners();
  }

  void updateUpperNavigatorIndex(int value) {
    upperNavigatorIndex = value;
    notifyListeners();
  }

  updateLowerAndUpperNavigationIndex(lowerValue, upperValue) {
    index = lowerValue;
    upperNavigatorIndex = upperValue;
    notifyListeners();
  }

  updateProfilePhoto(File newFile) {
    profilePhotoFile = newFile;
    notifyListeners();
  }

  updateProfilePhotoStr(String newStr) {
    profilePhoto64 = newStr;
    notifyListeners();
  }

  updateAddressProofFrontPhoto(File newFile) {
    addressProofFrontPhotoFile = newFile;
    notifyListeners();
  }

  updateAddressProofFrontPhotoStr(String newStr) {
    addressProofFrontPhoto64 = newStr;
    notifyListeners();
  }

  updateAddressProofBackPhoto(File newFile) {
    addressProofBackPhotoFile = newFile;
    notifyListeners();
  }

  updateAddressProofBackPhotoStr(String newStr) {
    addressProofBackPhoto64 = newStr;
    notifyListeners();
  }

  updatePanFrontPhoto(File newFile) {
    panFrontPhotoFile = newFile;
    notifyListeners();
  }

  updatePanFrontPhotoStr(String newStr) {
    panFrontPhoto64 = newStr;
    notifyListeners();
  }

  updateCompanyIdProofPhoto(File newFile) {
    companyIdProofPhotoFile = newFile;
    notifyListeners();
  }

  updateCompanyIdProofPhotoStr(String newStr) {
    companyIdProofPhoto64 = newStr;
    notifyListeners();
  }

  void updatePrice(value) {
    price = value;
    notifyListeners();
  }

  void updateUnitValue() {
    if (perTruck) {
      unitValue = "PER_TRUCK";
    } else if (perTon) {
      unitValue = "PER_TON";
    } else if (unitValue == "") {
      return null;
    }
    notifyListeners();
  }

  //------------------------FUNCTIONS--------------------------------------------------------------------------

  void clearLoadingPointFindLoad() {
    loadingPointCityFindLoad = "";
    loadingPointStateFindLoad = "";
    notifyListeners();
  }

  void clearUnloadingPointFindLoad() {
    unloadingPointCityFindLoad = "";
    unloadingPointStateFindLoad = "";
    notifyListeners();
  }

  void updateLoadingPointFindLoad(
      {required String city, required String state}) {
    loadingPointCityFindLoad = city;
    loadingPointStateFindLoad = state;
    notifyListeners();
  }

  void updateUnloadingPointFindLoad(
      {required String city, required String state}) {
    unloadingPointCityFindLoad = city;
    unloadingPointStateFindLoad = state;
    notifyListeners();
  }

  updateControllerOne(value) {
    controller1 = value;
    notifyListeners();
  }

  updateControllerTwo(value) {
    controller2 = value;
    notifyListeners();
  }

  //////////////
  void clearLoadingPointPostLoad() {
    loadingPointCityPostLoad = "";
    loadingPointStatePostLoad = "";
    notifyListeners();
  }

  void clearUnloadingPointPostLoad() {
    unloadingPointCityPostLoad = "";
    unloadingPointStatePostLoad = "";
    notifyListeners();
  }

  void updateLoadingPointPostLoad(
      {required String city, required String state}) {
    loadingPointCityPostLoad = city;
    loadingPointStatePostLoad = state;

    notifyListeners();
  }

  void updateUnloadingPointPostLoad(
      {required String city, required String state}) {
    unloadingPointCityPostLoad = city;
    unloadingPointStatePostLoad = state;

    notifyListeners();
  }

  void updateIndex(int newValue) {
    index = newValue;
    notifyListeners();
  }

  //functions for login screen

  void updatePhoneController(String value) {
    phoneController = value;
    print(phoneController);
    notifyListeners();
  }

  void updateInputControllerLengthCheck(bool value) {
    inputControllerLengthCheck = value;
    notifyListeners();
  }

  void updateButtonColor(dynamic value) {
    buttonColor = value;
    notifyListeners();
  }

  void updateSmsCode(value) {
    smsCode = value;
    notifyListeners();
  }

  void updateProductType(value) {
    productType = value;
    notifyListeners();
  }

  //TODO: name change to something more relevant
  void clearAll() {
    inputControllerLengthCheck = false;
    buttonColor = MaterialStateProperty.all<Color>(Colors.grey);

    smsCode = '';
    notifyListeners();
  }

//-------------------------------------

  // functions for add truck pages

  void updateTruckTypeValue(value) {
    truckTypeValue = value;
    notifyListeners();
  }

  void updatePassingWeightValue(value) {
    passingWeightValue = value;
    notifyListeners();
  }

  void updateTotalTyresValue(value) {
    totalTyresValue = value;
    notifyListeners();
  }

  void updateTruckLengthValue(value) {
    truckLengthValue = value;
    notifyListeners();
  }

  void updateDriverDetailsValue(value) {
    driverIdValue = value;
    notifyListeners();
  }

  void updateTruckNumberValue(value) {
    truckNumberValue = value;
    notifyListeners();
  }

  void updateTruckNumber(value) {
    truckNumber = value;
    notifyListeners();
  }

  void updateTruckId(value) {
    truckId = value;
    notifyListeners();
  }

  void updateResetActive(bool value) {
    resetActive = value;
    notifyListeners();
  }

  void resetUnitValue() {
    perTon = false;
    perTruck = false;
  }

  void resetTruckFilters() {
    // productType = "Choose Product Type";
    truckTypeValue = '';
    passingWeightValue = 0;
    totalTyresValue = 0;
    // truckNumber = 0;
    truckLengthValue = 0;
    // price = 0;
    driverIdValue = '';
    // unitValue = "";
    // resetUnitValue();
    notifyListeners();
  }

  void resetPostLoadFilters() {
    productType = "Choose Product Type";
    truckTypeValue = '';
    passingWeightValue = 0;
    totalTyresValue = 0;
    truckNumber = 0;
    truckLengthValue = 0;
    price = 0;
    driverIdValue = '';
    unitValue = "";
    resetUnitValue();
    notifyListeners();
  }

  void resetPostLoadScreenOne() {
    clearLoadingPointPostLoad();
    clearUnloadingPointPostLoad();
    clearBookingDate();
    updateResetActive(false);
    notifyListeners();
  }

  void resetOnNewType() {
    passingWeightValue = 0;
    totalTyresValue = 0;
    truckLengthValue = 0;
    driverIdValue = '';
    truckNumber = 0;

    notifyListeners();
  }

  void clearProductType() {
    productType = "";
    notifyListeners();
  }

  void clearBookingDate() {
    bookingDate = "";
    notifyListeners();
  }

  void clearController() {
    controller = "";
    notifyListeners();
  }

  void resetTruckNumber() {
    truckNumberValue = '';
    notifyListeners();
  }

  void resetTruckNum() {
    truckNumber = 0;
    notifyListeners();
  }

  void updateDriverList(value) {
    driverList = value;
    notifyListeners();
  }

  bool postLoadScreenTwoButton() {
    if (truckNumber != 0 &&
        passingWeightValue != 0 &&
        truckTypeValue != '' &&
        productType != "Choose Product Type" &&
        ((perTruck != perTon) && price != 0 ||
            (perTruck == perTon) && price == 0)) {
      return true;
    } else {
      return false;
    }
  }

  void updateBookingDate(value) {
    bookingDate = value;
    notifyListeners();
  }

  bool postLoadScreenOneButton() {
    if (loadingPointCityPostLoad != "" &&
        bookingDate != "" &&
        unloadingPointCityPostLoad != '') {
      return true;
    } else {
      return false;
    }
  }

  void PerTruckTrue(truck, ton) {
    perTruck = truck;
    perTon = ton;

    notifyListeners();
  }

  void PerTonTrue(ton, truck) {
    perTon = ton;
    perTruck = truck;

    notifyListeners();
  }

  void updateCompletedDate(value) {
    completedDate = value;
    notifyListeners();
  }

  void updateOtpValid(value) {
    otpIsValid = value;
    notifyListeners();
  }

  void updatePostLoadError(value) {
    postLoadError = value;
    notifyListeners();
  }

  void updateLoadWidget(value) {
    loadWidget = value;
    notifyListeners();
  }

  bool showDialogPrice() {
    if (((perTruck != perTon) && price != 0 ||
        (perTruck == perTon) && price == 0)) {
      return false;
    } else {
      return true;
    }
  }

  // List truckModels = [];
  // List driverModels = [];
  // // bool updatedOnce = false;
  //
  // void updateTruckDriverModels(newTruckModels , newDriverModels , didUpdateOnce){
  //   truckModels = newTruckModels;
  //   driverModels = newDriverModels;
  //   // updatedOnce = didUpdateOnce;
  //   notifyListeners();
  // }

  bool isAddTruckSrcDropDown = false;

  updateIsAddTruckSrcDropDown(bool value) {
    isAddTruckSrcDropDown = value;
  }

//----------------------------------


 // Language locale Provider


  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
  if (!L10n.all.contains(locale)) return;

  _locale = locale;
  notifyListeners();
  }

  void clearLocale() {
  _locale = null;
  notifyListeners();
  }

// ------------------------------------------------
  // Language selection provider

  LanguageItem _languageItem = LanguageItem.English;

  LanguageItem get languageItem => _languageItem;

  void setLanguageItem(LanguageItem languageItems){
    _languageItem = languageItems;
    notifyListeners();
  }


}
