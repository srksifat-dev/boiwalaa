import '/model/order.dart';
import '/view/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'order_screen_details.dart';

Widget orderCard(
    BuildContext context, List<OrderItemModel> orderItems, int index) {
  final orderItem = orderItems[index];
  return GestureDetector(
    onTap: orderItem.orderStep == OrderStep.waitForConfirmation
        ? () {}
        : () => Get.to(
              () => OrderScreenDetails(
                orderItems: orderItems,
                index: index,
              ),
            ),
    child: Container(
      padding: EdgeInsets.only(
        left: context.percentWidth * 3,
        right: context.percentWidth * 3,
        bottom: context.percentWidth * 3,
      ),
      margin: EdgeInsets.only(bottom: context.percentWidth * 3),
      height: context.percentWidth * 30,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(context.percentWidth * 3)),
          color: Colors.grey[200]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order ID: ${orderItem.orderID}",
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: context.percentWidth * 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  final data = ClipboardData(text: orderItem.orderID);
                  Clipboard.setData(data);
                  Fluttertoast.showToast(
                      msg: "Order ID is copied in clipboard!");
                },
              ),
            ],
          ),
          Text(
            orderItem.orderTime,
            style: TextStyle(
              fontSize: context.percentWidth * 4,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: ${orderItem.totalPrice.toString()}",
                style: TextStyle(
                  fontSize: context.percentWidth * 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                // margin: EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: const BoxDecoration(
                    color: AppColors.deepAmber,
                    // border: Border.all(
                    //   color: LightColor.customBlack,
                    //   width: 1,
                    // ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  orderItem.orderStep == OrderStep.waitForConfirmation
                      ? "Wait for Confirmation"
                      : orderItem.orderStep == OrderStep.confirmed
                          ? "Confirmed"
                          : orderItem.orderStep == OrderStep.packed
                              ? "Packed"
                              : orderItem.orderStep == OrderStep.shipped
                                  ? "Shipped"
                                  : orderItem.orderStep ==
                                          OrderStep.readyToDelivery
                                      ? "Ready to Delivery"
                                      : "Delivered",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
