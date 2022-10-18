import 'package:boiwalaa/view/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'view/auth_screen/auth_screen.dart';
import 'view/main_screen/main_screen.dart';

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
  void initState(){
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
        : const MainScreen();
  }
}
