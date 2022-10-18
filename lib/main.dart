import 'package:boiwalaa/bindings/auth_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/view/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'root.dart';
import 'view/theme/theme_service.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  final GetStorage storage = GetStorage();
  initScreen = storage.read("initScreen");
  storage.write("password", "");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boiwalaa',
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeService().getThemeMode(),
      initialBinding: AuthBinding(),
      home: const Root(),
    );
  }
}

