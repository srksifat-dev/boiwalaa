import '/controller/cart_controller.dart';
import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SheetHeader extends StatelessWidget {
  final controller = Get.find<CartController>();
  final double fontSize;
  final double topMargin;
  // final double widthBox;

  SheetHeader({
    Key? key,
    required this.fontSize,
    required this.topMargin,
    // required this.widthBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: context.percentWidth * 5,
      right: context.percentWidth * 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Cart',
            style: TextStyle(
              color: AppColors.green,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          // WidthBox(widthBox),
          controller.sumCartQuantity() >= 100
              ? "99+"
                  .text
                  .align(TextAlign.right)
                  .white
                  .size(fontSize)
                  .color(AppColors.green)
                  .bold
                  .makeCentered()
              : controller.sumCartQuantity() >= 10
                  ? "${controller.sumCartQuantity()}"
                      .text
                      .color(AppColors.green)
                      .size(fontSize)
                      .bold
                      .makeCentered()
                  : "0${controller.sumCartQuantity()}"
                      .text
                      .color(AppColors.green)
                      .size(fontSize)
                      .bold
                      .makeCentered(),
        ],
      ),
    );
  }
}
