import 'dart:io';
import 'package:image_picker/image_picker.dart';


Future getImageFromCamera(var functionToUpdate) async {
  final picker = ImagePicker();
  var pickedFile = await picker.getImage(source: ImageSource.camera);
  // showModalBottomSheet(context: context, builder: (context) {
  //     return Container(
  //       height: 300,child: Row(
  //       children: [GestureDetector(onTap: () async {
  //         var filesc = await picker.getImage(source: ImageSource.gallery);
  //         setState(() {
  //           pickedFile = filesc;
  //         });
  //       },child: Container(
  //         color: Colors.red,
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text("gallery"))), GestureDetector(onTap: () async {
  //         var files = await picker.getImage(source: ImageSource.camera);
  //         setState(() {
  //           pickedFile = files;
  //         });
  //
  //         }, child: Container(
  //           color: Colors.blue,
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text("camera")))
  //       ],
  //     ),); });
  functionToUpdate(File(pickedFile!.path));
}