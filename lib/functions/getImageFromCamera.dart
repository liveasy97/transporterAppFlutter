import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liveasy/functions/getImageFromGallery.dart';
import 'package:liveasy/widgets/alertDialog/permissionDialog.dart';
import 'dart:io' as Io;
import 'package:permission_handler/permission_handler.dart';

void showPicker(var functionToUpdate, var strToUpdate, var context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      await getImageFromGallery(
                          functionToUpdate, strToUpdate, context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    await getImageFromCamera(
                        functionToUpdate, strToUpdate, context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
}

Future getImageFromCamera(
    var functionToUpdate, var strToUpdate, var context) async {
  var status = await Permission.camera.status;
  if (status.isDenied) {
    if (await Permission.camera.request().isGranted) {
      final picker = ImagePicker();
      var pickedFile = await picker.pickImage(source: ImageSource.camera);
      final bytes = await Io.File(pickedFile!.path).readAsBytes();
      String img64 = base64Encode(bytes);
      functionToUpdate(File(pickedFile.path));
      strToUpdate(img64);
    } else {
      if (await Permission.camera.isPermanentlyDenied) {
        final picker = ImagePicker();
        var pickedFile = await picker.pickImage(source: ImageSource.camera);
        final bytes = await Io.File(pickedFile!.path).readAsBytes();
        String img64 = base64Encode(bytes);
        functionToUpdate(File(pickedFile.path));
        strToUpdate(img64);
      } else {
        showDialog(context: context, builder: (context) => PermissionDialog());
      }
    }
  } else {
    final picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.camera);
    print("Picked file is $pickedFile");
    print("Picked file path is ${pickedFile!.path}");
    final bytes = await Io.File(pickedFile.path).readAsBytes();
    String img64 = base64Encode(bytes);
    print("Base64 is $img64");
    functionToUpdate(File(pickedFile.path));
    strToUpdate(img64);
  }
}
