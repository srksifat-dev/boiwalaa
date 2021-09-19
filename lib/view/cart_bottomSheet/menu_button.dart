import '/controller/cart_controller.dart';
import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuButton extends StatelessWidget {
  final controller = Get.find<CartController>();

  MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Positioned(
        //   //<-- Align the icon to bottom right corner
        //   right: 0,
        //   bottom: 0,
        //   child:
        Obx(
      () => Container(
        height: 70,
        width: context.percentWidth * 18,
        color: AppColors.green,
        child: controller.sumCartQuantity() >= 100
            ? "99+".text.white.bold.xl3.makeCentered()
            : "${controller.sumCartQuantity()}"
                .text
                .white
                .xl3
                .bold
                .makeCentered(),
      ),
      // ),
    );
  }
}
