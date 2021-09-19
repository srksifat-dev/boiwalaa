import 'package:boiwalaa/bindings/auth_binding.dart';
import 'package:boiwalaa/view/home_screen/home_screen.dart';
import 'package:boiwalaa/view/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '/view/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'view/auth_screen/auth_screen.dart';
import 'view/auth_screen/auth_view_1.dart';
import 'view/theme/theme_service.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  final GetStorage storage = GetStorage();
  initScreen = storage.read("initScreen");
  storage.write("password", "");
  // await storage.write("initScreen", 1);
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

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  late FirebaseAuth _auth;

  late User? _user;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.green,
              ),
            ),
          )
        : _user == null
            ? const AuthScreen()
            : const HomeScreen();
  }
}
