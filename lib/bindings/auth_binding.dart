import 'package:boiwalaa/controller/auth_controller.dart';
import 'package:boiwalaa/controller/cart_controller.dart';
import 'package:boiwalaa/controller/message_controller.dart';
import 'package:boiwalaa/controller/network_controller.dart';
import 'package:boiwalaa/controller/order_controller.dart';
import 'package:boiwalaa/controller/user_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<MessageController>(() => MessageController());
    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<NetworkController>(() => NetworkController());
  }
}
