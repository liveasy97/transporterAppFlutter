// page on hold until further notice.
//
// import 'dart:html';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:liveasy/widgets/addTrucksHeader.dart';
// import 'package:liveasy/constants/color.dart';
// import 'package:liveasy/constants/fontSize.dart';
// import 'package:liveasy/constants/fontWeights.dart';
// import 'package:liveasy/constants/spaces.dart';
//
// class UploadRCScreen extends StatefulWidget {
//   const UploadRCScreen({Key? key}) : super(key: key);
//
//   @override
//   _UploadRCScreenState createState() => _UploadRCScreenState();
// }
//
// class _UploadRCScreenState extends State<UploadRCScreen> {
//
//   File? _image;
//   final picker = ImagePicker();
//
//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//
//     setState(() {
//       _image = pickedFile as File?;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: getImage,
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, space_4),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Center(
//                 //   child: ,
//                 // ),
//                 // AddTrucksHeader(),
//                 // Text(
//                 //   'Upload RC for  Truck Number',
//                 //   style:  TextStyle(
//                 //     fontSize: size_11,
//                 //     color: truckGreen,
//                 //   ),
//                 // ),
//
//               ],
//             ),
//           ),
//         )
//       ),
//     );
//   }
// }
