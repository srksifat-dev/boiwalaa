import 'dart:js';

import 'package:boiwalaa/model/address.dart';
import 'package:boiwalaa/model/user.dart';
import 'package:boiwalaa/view/global_widget/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:postgres/postgres.dart';

class Database {
  PostgreSQLConnection? connection;

  Database() {
    connection = (connection == null || connection!.isClosed == true
        ? PostgreSQLConnection(
            'localhost',
            5432,
            'beta',
            username: 'sifat',
            password: '{(krstafis)(1998)}',
            timeoutInSeconds: 30,
          )
        : connection);
  }

  Future<void> createUser(UserModel user) async {
    try {
      await connection!.open();
      await connection!.transaction((connection) async {
        await connection.query(
            "INSERT INTO users(id,contact_number)VALUES(@id,@name)",
            substitutionValues: {
              "id": user.userId,
              "name": user.name,
            },
            allowReuse: true,
            timeoutInSeconds: 30);
      });
    } on PostgreSQLException catch (e) {
      messageSnackbar("Create New User Error", e.message!);
    }
  }

  Future<UserModel> fetchUser() async {
    UserModel? user;
    try {
      await connection!.open();
      await connection!.transaction((connection) async {
        dynamic result = await connection.query(
            "SELECT * FROM users WHERE contact_number = 0${GetStorage().read("contactNumber")}",
            allowReuse: true,
            timeoutInSeconds: 30);
        user = UserModel(
            userId: result[0],
            name: result[2],
            email: result[3],
            contactNumber: result[4],
            birthday: result[5]);
      });
    } on PostgreSQLException catch (e) {
      messageSnackbar("Fetch User Error", e.message!);
    }
    return user!;
  }

  Future<bool> checkUserExist() async {
    bool exist = false;
    try {
      await connection!.open();
      await connection!.transaction((connection) async {
        final dynamic result = await connection.query(
            "SELECT COUNT(*) FROM users WHERE contact_number = 0${GetStorage().read("contactNumber")}",
            allowReuse: true,
            timeoutInSeconds: 30);
        String fullCount = result[0].toString();
        int count = int.parse(fullCount.substring(1, fullCount.length - 1));
        if (count > 0) {
          exist = true;
        } else {
          exist = false;
        }
      });
    } on PostgreSQLException catch (e) {
      Get.snackbar(
        "Error",
        e.message!,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
    return exist;
  }

  Future<void>updateName(String name)async{
    try{
      await connection!.open();
      await connection!.transaction((connection) async{
        await connection.query("UPDATE users SET name = @name WHERE contact_number = 0${GetStorage().read("contactNumber")}",
        substitutionValues: {
          "name": name,
        },
        allowReuse: true,
        timeoutInSeconds: 30);
      });
    }on PostgreSQLException catch(e){
      Get.snackbar(
        "Error",
        e.message!,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void>updateEmail(String email)async{
    try{
      await connection!.open();
      await connection!.transaction((connection) async{
        await connection.query("UPDATE users SET email = @email WHERE contact_number = 0${GetStorage().read("contactNumber")}",
        substitutionValues: {
          "email": email,
        },
        allowReuse: true,
        timeoutInSeconds: 30);
      });
    }on PostgreSQLException catch(e){
      Get.snackbar(
        "Error",
        e.message!,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
  }

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> createNewUser(UserModel user) async {
  //   try {
  //     await _firestore
  //         .collection("users")
  //         .doc(user.contactNumber.toString())
  //         .collection("accountInfo")
  //         .doc("details")
  //         .set(user.toMap());
  //     print("User created");
  //     // return true;
  //   } on FirebaseException catch (e) {
  //     messageSnackbar("Create New User Error", e.message!);
  //     // return false;
  //   }
  // }

  // Future<UserModel> fetchUser() async {
  //   try {
  //     DocumentSnapshot _doc = await _firestore
  //         .collection("users")
  //         .doc("0${GetStorage().read("contactNumber")}")
  //         .collection("accountInfo")
  //         .doc("details")
  //         .get();
  //     print("User fetched");
  //     return UserModel.fromFirestore(_doc);
  //   } on FirebaseException catch (e) {
  //     messageSnackbar("Fetch User Error", e.message!);

  //     rethrow;
  //   }
  // }

  // Stream<UserModel> getUser() => _firestore.collection("users")
  //     .doc("0${GetStorage().read("contactNumber")}")
  //     .collection("accountInfo")
  //     .doc("details")
  //     .snapshots()
  //     .map((query) => UserModel.fromFirestore(query));

  // Future<void> updateName(String userId, String name) async {
  //   try {
  //     await _firestore
  //         .collection("users")
  //         .doc("0$userId")
  //         .collection("accountInfo")
  //         .doc("details")
  //         .update({"name": name});
  //     print("Name Updated");
  //   } on FirebaseException catch (e) {
  //     messageSnackbar("Updating Error", e.message!);
  //     rethrow;
  //   }
  // }

  // Future<void> updateEmail(String userId, String email) async {
  //   try {
  //     await _firestore
  //         .collection("users")
  //         .doc("0$userId")
  //         .collection("accountInfo")
  //         .doc("details")
  //         .update({"email": email});
  //     print("Email Updated");
  //   } on FirebaseException catch (e) {
  //     messageSnackbar("Updating Error", e.message!);
  //     rethrow;
  //   }
  // }

  // Future<void> addAddress(
  //   String userId,
  //   String addressName,
  //   String country,
  //   String state,
  //   String city,
  //   String detailAddress,
  // ) async {
  //   try {
  //     await _firestore
  //         .collection("users")
  //         .doc("0$userId")
  //         .collection("addressList")
  //         .doc(addressName)
  //         .set({
  //           "addressName":addressName,
  //       "country": country,
  //       "state": state,
  //       "city": city,
  //       "detailAddress": detailAddress
  //     });
  //     print("Address added");
  //   } on FirebaseException catch (e) {
  //     messageSnackbar("Updating Error", e.message!);
  //     rethrow;
  //   }
  // }

  // Future<void> deleteAddress(
  //   String userId,
  //   String addressName,
  // ) async {
  //   try {
  //     await _firestore
  //         .collection("users")
  //         .doc("0$userId")
  //         .collection("addressList")
  //         .doc(addressName)
  //         .delete();
  //   } on FirebaseException catch (e) {
  //     messageSnackbar("Deleting address Error", e.message!);
  //     rethrow;
  //   }
  // }

  // Stream<List<AddressModel>> getAddressList() => _firestore.collection("users")
  //     .doc("0${GetStorage().read("contactNumber")}")
  //     .collection("addressList")
  //     .snapshots()
  //     .map((query) =>
  //         query.docs.map((item) => AddressModel.fromFirestore(item)).toList());
}
