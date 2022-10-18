import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String addressName;
  String country;
  String state;
  String city;
  String detailAddress;
  AddressModel({
    this.addressName = "",
    this.country = "",
    this.state = "",
    this.city = "",
    this.detailAddress = "",
  });

  AddressModel.fromFirestore(DocumentSnapshot data)
      : addressName = data["addressName"],
        country = data["country"],
        state = data["state"],
        city = data["city"],
        detailAddress = data["detailAddress"];
}
