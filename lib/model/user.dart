
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userId;
  final String role;
  final String name;
  final String email;
  final String? contactNumber;
  final DateTime? birthday;

  UserModel({
    this.userId,
    this.role = "User",
    this.name = "Your name",
    this.email = "youremailaddress@example.com",
    this.contactNumber,
    this.birthday,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     "userId": userId,
  //     "role": role,
  //     "name": name,
  //     "email": email,
  //     "contactNumber": contactNumber,
  //   };
  // }

  // UserModel.fromFirestore(DocumentSnapshot data)
  //     : userId = data["userId"],
  //       role = data["role"],
  //       name = data["name"],
  //       email = data["email"],
  //       contactNumber = data["contactNumber"];

  // static UserModel fromFirestore(DocumentSnapshot snap) {
  //   UserModel userModel = UserModel(
  //     userId: snap["userId"],
  //     role: snap["role"],
  //     name: snap["name"],
  //     email: snap["email"],
  //     contactNumber: snap["contactNumber"],
  //   );
  //   return userModel;
  // }
}
