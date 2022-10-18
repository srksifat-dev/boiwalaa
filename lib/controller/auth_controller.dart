import 'package:boiwalaa/controller/user_controller.dart';
import 'package:boiwalaa/view/global_widget/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:password_strength/password_strength.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  final userController = Get.put(UserController());
  // Firebase instances

  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Rx<User?> firebaseUser;
  // User? get firebaseUser => _firebaseUser.value;
  late CollectionReference collectionReference;
// TextEditing Controllers
  // TextEditingController nameController = TextEditingController();
  // TextEditingController contactNumberController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();
  // TextEditingController otpController = TextEditingController();

// Focus Nodes
  // FocusNode nameFocusNode = FocusNode();
  // FocusNode contactNumberFocusNode = FocusNode();
  // FocusNode passwordFocusNode = FocusNode();
  // FocusNode confirmPasswordFocusNode = FocusNode();
  // FocusNode otpFocusNode = FocusNode();

// Form keys
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

// Observable variables

  String verificationId = "";

  @override
  void onInit() async {
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.authStateChanges());
    collectionReference = firestore.collection("users");

    super.onInit();
  }

// validators

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Enter your name";
    } else if (value.length < 3) {
      return "Enter your real name";
    }
    return null;
  }

  String? validateContactNumber(String value) {
    if (value.isEmpty) {
      return "Enter contact number";
    }
    if (!value.startsWith("1") || value.length < 10) {
      return "Enter valid Contact Number";
    }
    return null;
  }

  String? validateSignInPassword(String value) {
    if (value.isEmpty) {
      return "Enter password";
    } else if (GetStorage().read("password") == "") {
      return "May be you didn't sign up before!";
    } else if (value != GetStorage().read("password")) {
      return "Forgot password?";
    }
    return null;
  }

  String? validateSignUpPassword(String value) {
    double strength = estimatePasswordStrength(value);
    if (strength < 0.3) {
      return "Your password is so weak";
    } else if (strength < 0.7) {
      return "Enter stronger password";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Enter email address";
    } else if (!GetUtils.isEmail(value)) {
      return "Enter valid email";
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      userController.clear();
    } on FirebaseAuthException catch (e) {
      messageSnackbar("Sign Out Error", "${e.message}");
    }
  }

  // void checkSignIn() {
  //   final isValid = signInFormKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   signInFormKey.currentState!.save();
  // }
}
