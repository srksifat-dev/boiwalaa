import 'package:boiwalaa/model/address.dart';
import 'package:boiwalaa/model/user.dart';
import 'package:boiwalaa/view/global_widget/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNewUser(UserModel user) async {
    try {
      await _firestore
          .collection("users")
          .doc(user.contactNumber.toString())
          .collection("accountInfo")
          .doc("details")
          .set(user.toMap());
      print("User created");
      // return true;
    } on FirebaseException catch (e) {
      messageSnackbar("Create New User Error", e.message!);
      // return false;
    }
  }

  // Future<UserModel> getUser(String uid) async {
  //   try {
  //     DocumentSnapshot _doc = await _firestore
  //         .collection("users")
  //         .doc(uid)
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

  Stream<UserModel> getUser() => _firestore.collection("users")
      .doc("0${GetStorage().read("contactNumber")}")
      .collection("accountInfo")
      .doc("details")
      .snapshots()
      .map((query) => UserModel.fromFirestore(query));

  Future<void> updateName(String userId, String name) async {
    try {
      await _firestore
          .collection("users")
          .doc("0$userId")
          .collection("accountInfo")
          .doc("details")
          .update({"name": name});
      print("Name Updated");
    } on FirebaseException catch (e) {
      messageSnackbar("Updating Error", e.message!);
      rethrow;
    }
  }

  Future<void> updateEmail(String userId, String email) async {
    try {
      await _firestore
          .collection("users")
          .doc("0$userId")
          .collection("accountInfo")
          .doc("details")
          .update({"email": email});
      print("Email Updated");
    } on FirebaseException catch (e) {
      messageSnackbar("Updating Error", e.message!);
      rethrow;
    }
  }

  Future<void> addAddress(
    String userId,
    String addressName,
    String country,
    String state,
    String city,
    String detailAddress,
  ) async {
    try {
      await _firestore
          .collection("users")
          .doc("0$userId")
          .collection("addressList")
          .doc(addressName)
          .set({
            "addressName":addressName,
        "country": country,
        "state": state,
        "city": city,
        "detailAddress": detailAddress
      });
      print("Address added");
    } on FirebaseException catch (e) {
      messageSnackbar("Updating Error", e.message!);
      rethrow;
    }
  }

  Future<void> deleteAddress(
    String userId,
    String addressName,
  ) async {
    try {
      await _firestore
          .collection("users")
          .doc("0$userId")
          .collection("addressList")
          .doc(addressName)
          .delete();
    } on FirebaseException catch (e) {
      messageSnackbar("Deleting address Error", e.message!);
      rethrow;
    }
  }

  Stream<List<AddressModel>> getAddressList() => _firestore.collection("users")
      .doc("0${GetStorage().read("contactNumber")}")
      .collection("addressList")
      .snapshots()
      .map((query) =>
          query.docs.map((item) => AddressModel.fromFirestore(item)).toList());
}
