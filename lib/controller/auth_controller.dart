import 'package:boiwalaa/model/user.dart';
import 'package:boiwalaa/view/global_widget/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:password_strength/password_strength.dart';

import '/model/address.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Rx<User?> firebaseUser;
  Rx<UserModel> userModel = UserModel().obs;

  late CollectionReference collectionReference;

  var addressList = List<Address>.empty(growable: true).obs;

  var name = "Boiwalaa";
  var email = "yourEmail@example.com";
  var password = "";
  var contactNumber = "";

  @override
  void onInit() async {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    collectionReference = firestore.collection("users");
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> addUser(UserModel userModel) {
    return collectionReference
        .doc(userModel.contactNumber.toString())
        .collection("account")
        .doc("details")
        .set(userModel.toMap())
        .catchError((error) {
      messageSnackbar("Add User Error", error.message);
    });
  }

  Future<UserModel> fetchUser(String userId) {
    return collectionReference
        .doc(userId)
        .collection("account")
        .doc("details")
        .get()
        .then((snapshot) => UserModel.fromFirestore(snapshot.data()));
  }

  String? validateContactNumber(String value) {
    if (value.isEmpty) {
      return "Enter contact number";
    }
    if (!value.startsWith("01") || value.length < 11) {
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

  void signOut() async {
    try {
      await _auth.signOut();
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
