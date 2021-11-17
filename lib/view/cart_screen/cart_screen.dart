import 'package:boiwalaa/controller/cart_controller.dart';
import 'package:boiwalaa/controller/network_controller.dart';
import 'package:boiwalaa/view/cart_bottomSheet/animated_count.dart';
import 'package:boiwalaa/view/cart_bottomSheet/cart_card.dart';
import 'package:boiwalaa/view/checkout_screen/checkout_screen.dart';
import 'package:boiwalaa/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  final cartController = Get.find<CartController>();
  final networkController = Get.find<NetworkController>();
  CartScreen({Key? key}) : super(key: key);

  final double _begin = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "Cart".text.black.make(),
        ),
        body: Obx(
          () => Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.percentWidth * 5),
                  height: context.percentHeight * 78,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: cartController.cart.length,
                    itemBuilder: (context, index) {
                      // final cartItem = controller.cart[index];
                      return CartCard(
                        controller: cartController,
                        index: index,
                      );
                    },
                    separatorBuilder: (_, __) {
                      return HeightBox(context.percentHeight * 1);
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: context.percentHeight * 7.5,
                left: 0,
                right: 0,
                child: Center(
                  child: CountUp(
                    prefix: "Total: ",
                    suffix: " ৳",
                    begin: _begin,
                    end: cartController.sumCartPrice().toDouble(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: context.percentWidth * 5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // child: "Total: ${controller.sumCartPrice()} ৳"
                //     .text
                //     .xl
                //     .white
                //     .bold
                //     .makeCentered(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => showCheckoutDialog(context),
                  child: Container(
                    height: context.percentHeight * 6,
                    width: double.infinity,
                    color: AppColors.deepAmber,
                    child: Center(
                      child: "Checkout".text.bold.black.xl2.makeCentered(),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: networkController.connectionStatus.value == 0
                      ? MaterialBanner(
                          leading: const Icon(
                            Icons.info,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.amber,
                          content: "You have no Internet Connection."
                              .text
                              .black
                              .make(),
                          actions: [
                              TextButton(onPressed: () {}, child: const Text(""))
                            ])
                      : Container())
            ],
          ),
        ));
  }
}
