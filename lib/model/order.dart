import '/model/cart.dart';

enum OrderStep {
  waitForConfirmation,
  confirmed,
  packed,
  shipped,
  readyToDelivery,
  delivered,
}

enum DeliveryMethod {
  cod,
  scs,
}

enum DeliveryPlace { inside, outside }

class OrderItemModel {
  String orderID;
  final List<CartItemModel> cartItem;
  String orderTime;
  OrderStep orderStep;
  DeliveryMethod deliveryMethod;
  int totalPrice;
  String country;
  String state;
  String city;
  String detailAddress;
  String transactionID;
  String name;
  String email;
  String contactNo;

  OrderItemModel({
    required this.orderID,
    required this.cartItem,
    required this.orderTime,
    this.orderStep = OrderStep.confirmed,
    this.deliveryMethod = DeliveryMethod.scs,
    required this.totalPrice,
    required this.country,
    required this.state,
    required this.city,
    required this.detailAddress,
    required this.transactionID,
    required this.name,
    required this.email,
    required this.contactNo,
  });
}
