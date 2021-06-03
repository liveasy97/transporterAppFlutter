import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/findLoadScreen.dart';
import 'package:liveasy/screens/loadDetailsScreen.dart';
import 'package:liveasy/screens/login_screen.dart';
import 'package:liveasy/screens/navigationScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderData>(
      create: (context) => ProviderData(),
      child: GetMaterialApp(
        home: FindLoadScreen(),
      ),
    );
  }
}
