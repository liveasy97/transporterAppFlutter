import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liveasy/widgets/alertDialog/permissionDialog.dart';
import 'dart:io' as Io;
import 'package:permission_handler/permission_handler.dart';

Future getImageFromCamera(var functionToUpdate, var strToUpdate, var context) async {
  var status = await Permission.camera.status;
  if (status.isDenied) {
    if(await Permission.camera.request().isGranted) {
      final picker = ImagePicker();
      var pickedFile = await picker.getImage(source: ImageSource.camera);
      final bytes = await Io.File(pickedFile!.path).readAsBytes();
      String img64 = base64Encode(bytes);
      functionToUpdate(File(pickedFile.path));
      strToUpdate(img64);
    } else {
      if(await Permission.camera.isPermanentlyDenied) {
        final picker = ImagePicker();
        var pickedFile = await picker.getImage(source: ImageSource.camera);
        final bytes = await Io.File(pickedFile!.path).readAsBytes();
        String img64 = base64Encode(bytes);
        functionToUpdate(File(pickedFile.path));
        strToUpdate(img64);
      } else {
        showDialog(
            context: context,
            builder: (context) => PermissionDialog());
      }
    }
  } else {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    final bytes = await Io.File(pickedFile!.path).readAsBytes();
    String img64 = base64Encode(bytes);
    functionToUpdate(File(pickedFile.path));
    strToUpdate(img64);
  }
}