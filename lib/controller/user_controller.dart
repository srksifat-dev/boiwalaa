import 'package:boiwalaa/model/address.dart';
import 'package:boiwalaa/model/user.dart';
import 'package:boiwalaa/services/database.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // final Rx<UserModel> obsUser = UserModel().obs;
  UserModel? user;

  // set user(UserModel value) => obsUser.value = value;

  final RxList<AddressModel> obsAddressList =
      List<AddressModel>.empty(growable: true).obs;

  get addressList => obsAddressList;

  void clear() {
    // obsUser.value = UserModel();
  }

  @override
  void onInit() {
    
    super.onInit();
  }
}
