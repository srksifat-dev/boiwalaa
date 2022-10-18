import '/controller/auth_controller.dart';
import '/view/track_order_screen/item_carousel.dart';
import '/view/track_order_screen/order_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import '/model/order.dart';
import '/view/theme/colors.dart';

class OrderScreenDetails extends StatelessWidget {
  OrderScreenDetails({
    Key? key,
    required this.index,
    required this.orderItems,
  }) : super(key: key);
  final authController = Get.find<AuthController>();
  final int index;
  final List<OrderItemModel> orderItems;

  @override
  Widget build(BuildContext context) {
    final cartItems = orderItems[index].cartItem;
    final orderItem = orderItems[index];
    return Scaffold(
      appBar: AppBar(
        title: orderItems[index].orderID.text.make(),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.percentWidth * 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.percentWidth * 3),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightBox(context.percentWidth * 5),
                    "Items".text.xl3.bold.make().px(context.percentWidth * 5),
                    HeightBox(context.percentWidth * 5),
                    ItemCarousel(cartItems: cartItems),
                  ],
                ),
              ),
              HeightBox(context.percentWidth * 5),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: context.percentWidth * 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.percentWidth * 3),
                  color: Colors.grey[200],
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightBox(context.percentWidth * 5),
                    "Receiver Info".text.xl3.bold.make(),
                    HeightBox(context.percentWidth * 5),
                    Row(
                      children: [
                        SizedBox(
                          width: context.percentWidth * 20,
                          child: "Name".text.bold.make(),
                        ),
                        Expanded(
                            child: ": ${orderItems[index].name}".text.make()),
                      ],
                    ),
                    HeightBox(context.percentWidth * 1),
                    Row(
                      children: [
                        SizedBox(
                          width: context.percentWidth * 20,
                          child: "Contact No.".text.bold.make(),
                        ),
                        Expanded(
                            child:
                                ": ${orderItems[index].contactNo}".text.make()),
                      ],
                    ),
                    HeightBox(context.percentWidth * 1),
                    Row(
                      children: [
                        SizedBox(
                          width: context.percentWidth * 20,
                          child: "Email".text.bold.make(),
                        ),
                        Expanded(
                            child: ": ${orderItems[index].email}".text.make()),
                      ],
                    ),
                    HeightBox(context.percentWidth * 1),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: context.percentWidth * 20,
                          child: "Address".text.bold.make(),
                        ),
                        Expanded(
                            child:
                                ": ${orderItems[index].detailAddress}, ${orderItems[index].city}, ${orderItems[index].state}, ${orderItems[index].country}"
                                    .text
                                    .make()),
                      ],
                    ),
                    HeightBox(context.percentWidth * 5),
                  ],
                ),
              ),
              HeightBox(context.percentWidth * 5),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.percentWidth * 3),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightBox(context.percentWidth * 5),
                    "Order Status"
                        .text
                        .xl3
                        .bold
                        .make()
                        .px(context.percentWidth * 5),
                    HeightBox(context.percentWidth * 5),
                    OrderStatus(
                      index: index,
                      asset: Lottie.asset("assets/images/confirmation.json"),
                      orderStatus: "Confirmed",
                      orderStatusColor:
                          orderItem.orderStep == OrderStep.confirmed
                              ? Colors.black
                              : Colors.grey,
                      orderTime: orderItem.orderStep == OrderStep.confirmed
                          ? orderItem.orderTime
                          : "",
                      orderTimeColor: orderItem.orderStep == OrderStep.confirmed
                          ? Colors.black
                          : Colors.grey,
                      assetDelayTime: 100,
                      childDelayTime: 300,
                    ),
                    OrderStatus(
                      index: index,
                      asset: orderItem.orderStep == OrderStep.packed
                          ? Lottie.asset("assets/images/packed.json")
                          : Image.asset(
                              "assets/images/packed-grey.png",
                              height: context.percentWidth * 8,
                            ),
                      orderStatus: "Packed",
                      orderStatusColor: orderItem.orderStep == OrderStep.packed
                          ? Colors.black
                          : Colors.grey,
                      orderTime: orderItem.orderStep == OrderStep.packed
                          ? orderItem.orderTime
                          : "",
                      orderTimeColor: orderItem.orderStep == OrderStep.packed
                          ? Colors.black
                          : Colors.grey,
                      assetDelayTime: 200,
                      childDelayTime: 400,
                    ),
                    OrderStatus(
                      index: index,
                      asset: orderItem.orderStep == OrderStep.shipped
                          ? Lottie.asset("assets/images/shipped.json")
                          : Image.asset(
                              "assets/images/shipped-grey.png",
                              height: context.percentWidth * 6,
                            ),
                      orderStatus: "Shipped",
                      orderStatusColor: orderItem.orderStep == OrderStep.shipped
                          ? Colors.black
                          : Colors.grey,
                      orderTime: orderItem.orderStep == OrderStep.shipped
                          ? orderItem.orderTime
                          : "",
                      orderTimeColor: orderItem.orderStep == OrderStep.shipped
                          ? Colors.black
                          : Colors.grey,
                      assetDelayTime: 300,
                      childDelayTime: 500,
                    ),
                    orderItem.deliveryMethod == DeliveryMethod.cod
                        ? OrderStatus(
                            index: index,
                            asset:
                                orderItem.orderStep == OrderStep.readyToDelivery
                                    ? Lottie.asset(
                                        "assets/images/readyToDelivery.json")
                                    : Image.asset(
                                        "assets/images/readyToDelivery-grey.png",
                                        height: context.percentWidth * 8,
                                      ),
                            orderStatus: "Ready to Delivery",
                            orderStatusColor:
                                orderItem.orderStep == OrderStep.readyToDelivery
                                    ? Colors.black
                                    : Colors.grey,
                            orderTime:
                                orderItem.orderStep == OrderStep.readyToDelivery
                                    ? orderItem.orderTime
                                    : "",
                            orderTimeColor:
                                orderItem.orderStep == OrderStep.readyToDelivery
                                    ? Colors.black
                                    : Colors.grey,
                            assetDelayTime: 400,
                            childDelayTime: 600,
                          )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    orderItem.deliveryMethod == DeliveryMethod.cod
                        ? OrderStatus(
                            index: index,
                            asset: orderItem.orderStep == OrderStep.delivered
                                ? Lottie.asset("assets/images/delivered.json")
                                : Image.asset(
                                    "assets/images/delivered-grey.png",
                                    height: context.percentWidth * 8,
                                  ),
                            orderStatus: "Delivered",
                            orderStatusColor:
                                orderItem.orderStep == OrderStep.delivered
                                    ? Colors.black
                                    : Colors.grey,
                            orderTime:
                                orderItem.orderStep == OrderStep.delivered
                                    ? orderItem.orderTime
                                    : "",
                            orderTimeColor:
                                orderItem.orderStep == OrderStep.delivered
                                    ? Colors.black
                                    : Colors.grey,
                            assetDelayTime: 500,
                            childDelayTime: 700,
                          )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
