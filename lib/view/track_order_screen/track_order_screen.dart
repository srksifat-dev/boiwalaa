import '/controller/cart_controller.dart';
import '/controller/order_controller.dart';
import '/model/order.dart';
import '/view/theme/colors.dart';
import '/view/track_order_screen/order_card.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class TrackOrder extends StatelessWidget {
  TrackOrder({Key? key}) : super(key: key);
  final orderController = Get.find<OrderController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Track your order".text.make(),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.percentWidth * 5,
          right: context.percentWidth * 5,
          top: context.percentWidth * 5,
        ),
        child: ListView.builder(
            itemCount: orderController.orderList.length,
            itemBuilder: (context, index) {
              final orderItems = orderController.orderList;
              final reverseOrderList =
                  List<OrderItemModel>.from(orderItems.reversed);
              return orderCard(context, reverseOrderList, index);
            }),
      ),
    );
  }
}
