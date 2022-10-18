import '/model/cart.dart';
import '/model/order.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var orderList = List<OrderItemModel>.empty(growable: true).obs;
  DeliveryMethod deliveryMethod = DeliveryMethod.cod;
  DeliveryPlace deliveryPlace = DeliveryPlace.inside;
  // var deliveryCost = 0.obs;
  // var orders = List<CartItem>.empty(growable: true).obs;

  int sumOrderPrice(List<CartItemModel> cartList) {
    return cartList.fold(
        0,
        (previousValue, element) =>
            previousValue + element.book.discountedPercent * element.quantity);
  }

  int deliveryCharge(DeliveryPlace deliveryPlace, DeliveryMethod method) {
    return method == DeliveryMethod.cod
        ? deliveryPlace == DeliveryPlace.inside
            ? 60
            : 100
        : 50;
  }

  // int sumOrderQuantity() {
  //   return orderList.fold(
  //       0, (previousValue, element) => previousValue + element.quantity);
  // }

  // RxInt cartItemQuantity(OrderItem orderItem) {
  //   return orderItem.quantity.obs;
  // }

  // void addProductIntoOrderList(CartItem cartItem) {
  //   orders.add(cartItem);
  // }

  void addOrder(OrderItemModel orderItem) {
    orderList.add(orderItem);
  }
}
