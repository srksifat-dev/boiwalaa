import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:velocity_x/velocity_x.dart';

import '/controller/order_controller.dart';

class OrderStatus extends StatelessWidget {
  OrderStatus({
    Key? key,
    required this.asset,
    required this.childDelayTime,
    required this.assetDelayTime,
    required this.orderStatus,
    required this.index,
    required this.orderTimeColor,
    required this.orderStatusColor,
    required this.orderTime,
  }) : super(key: key);
  final Widget asset;
  final int childDelayTime;
  final int assetDelayTime;
  final String orderStatus;
  final int index;
  final orderController = Get.put(OrderController());
  final Color orderTimeColor;
  final Color orderStatusColor;
  final String orderTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.percentHeight * 10,
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.4,
        indicatorStyle: IndicatorStyle(
          width: context.percentWidth * 15,
          height: context.percentWidth * 15,
          indicator: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ZoomIn(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: assetDelayTime),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: context.percentWidth * 6,
                child: ZoomIn(
                  duration: const Duration(milliseconds: 500),
                  delay: Duration(milliseconds: assetDelayTime),
                  child: asset,
                ),
              ),
            ),
          ),
        ),
        startChild: FadeInRight(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: childDelayTime),
          from: 30,
          child: Text(
            orderTime,
            style: TextStyle(
              color: orderTimeColor,
              fontSize: context.percentWidth * 4,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        endChild: FadeInLeft(
          delay: Duration(milliseconds: childDelayTime),
          duration: const Duration(milliseconds: 500),
          from: 30,
          child: Text(
            orderStatus,
            style: TextStyle(
              color: orderStatusColor,
              fontSize: context.percentWidth * 6,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
