import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:boiwalaa/model/address.dart';
import 'package:boiwalaa/model/cart.dart';
import 'package:boiwalaa/model/order.dart';

class UserModel {
  final String? userId;
  final String role;
  final String? name;
  final String email;
  final int? contactNumber;
  final List<Address>? addresses;
  final List<CartItem>? cartItems;
  final List<OrderItem>? orderItems;

  UserModel({
    this.userId,
    this.role = "User",
    this.name,
    this.email = "youremailaddress@example.com",
    this.contactNumber,
    this.addresses,
    this.cartItems,
    this.orderItems,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "role": role,
      "name": name,
      "email": email,
      "contactNumber":contactNumber,
      "addresses": addresses,
      "cartItems":cartItems,
      "orderItems":orderItems,
    };
  }

  UserModel.fromFirestore(Map<String, dynamic>? data)
      : userId = data!["userId"],
        role = data["role"],
        name = data["name"],
        email = data["email"],
        contactNumber = data["contactNumber"],
        addresses = data["addresses"],
        cartItems = data["cartItems"],
        orderItems = data["orderItems"];
}
