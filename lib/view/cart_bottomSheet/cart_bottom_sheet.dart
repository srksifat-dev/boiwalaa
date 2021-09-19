import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controller/cart_controller.dart';
import '/view/cart_bottomSheet/animated_count.dart';
import '/view/cart_bottomSheet/cart_card.dart';
import '/view/cart_bottomSheet/sheet_header.dart';
import '/view/checkout_screen/checkout_screen.dart';
import '/view/theme/colors.dart';

const double minHeight = 100;

const double iconStartSize = 44; //<-- add edge values
const double iconEndSize = 120; //<-- add edge values
const double iconStartMarginTop = 36; //<-- add edge values
const double iconEndMarginTop = 80; //<-- add edge values
const double iconsVerticalSpacing = 24; //<-- add edge values
const double iconsHorizontalSpacing = 16;

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({Key? key}) : super(key: key);

  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<CartController>();

  late AnimationController _controller;
  double get maxHeight => context.percentHeight * 100;

  double get headerTopMargin => lerp(8, 50)!;

  double get cartTopMargin => lerp(35, 90)!;

  double get widthBox =>
      lerp(context.percentWidth * 78, context.percentWidth * 70)!;

  double get headerFontSize => lerp(14, 24)!;

  double get itemBorderRadius => lerp(8, 24)!; //<-- increase item border radius

  double get iconSize =>
      lerp(iconStartSize, iconEndSize)!; //<-- increase icon size

  double iconTopMargin(int index) =>
      lerp(iconStartMarginTop,
          iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize))! +
      headerTopMargin; //<-- calculate top margin based on header margin, and size of all of icons above (from small to big)

  double iconLeftMargin(int index) =>
      lerp(index * (iconsHorizontalSpacing + iconStartSize), 0)!;

  double? lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);

  double get iconLeftBorderRadius =>
      itemBorderRadius; //<-- Left border radius stays the same

  double get iconRightBorderRadius => lerp(8, 0)!;

  late bool _swipeUp;

  final double _begin = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 600),
    );
    _swipeUp = false;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _toggle() {
  //   final bool isOpen = _controller.status == AnimationStatus.completed;
  //   _controller.fling(velocity: isOpen ? -2 : 2);
  // }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! /
        maxHeight; //<-- Update the _controller.value by the movement done by user.
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy /
        maxHeight; //<-- calculate the velocity of the gesture
    if (flingVelocity < 0.0) {
      _controller.fling(
          velocity:
              math.max(2.0, -flingVelocity)); //<-- either continue it upwards
      _swipeUp = true;
    } else if (flingVelocity > 0.0) {
      _controller.fling(
          velocity:
              math.min(-2.0, -flingVelocity)); //<-- or continue it downwards
      _swipeUp = false;
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
    } //<-- or just continue to whichever edge is closer
  }

  // Widget _buildIcon(CartItem cartItem) {
  //   int index = controller.cart.indexOf(cartItem); //<-- Get index of the event
  //   return Positioned(
  //     height: iconSize, //<-- Specify icon's size
  //     // width: iconSize, //<-- Specify icon's size
  //     top: iconTopMargin(index), //<-- Specify icon's top margin
  //     left: iconLeftMargin(index), //<-- Specify icon's left margin
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.horizontal(
  //         left: Radius.circular(itemBorderRadius), //<-- Set the rounded corners
  //         right: Radius.circular(itemBorderRadius),
  //       ),
  //       child: Image.asset(
  //         demoBooks[index].image,
  //         fit: BoxFit.cover,
  //         alignment: Alignment(
  //             lerp(1, 0)!, 0), //<-- Play with alignment for extra style points
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildFullItem(Book book) {
  //   int index = books.indexOf(book);
  //   return CartCard(
  //     book: book,
  //     topMargin: iconTopMargin(index),
  //     leftMargin: iconLeftMargin(index),
  //     height: iconSize,
  //     isVisible: _controller.status == AnimationStatus.completed,
  //     borderRadius: itemBorderRadius,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Positioned(
            height: lerp(minHeight, maxHeight),
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              // onTap: _toggle,
              onVerticalDragUpdate:
                  _handleDragUpdate, //<-- Add verticalDragUpdate callback
              onVerticalDragEnd: _handleDragEnd,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.mediumAmber,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(context.percentWidth * 5),
                  ),
                ),
                child: Obx(
                  () => Stack(
                    children: [
                      SheetHeader(
                        // widthBox: widthBox,
                        fontSize: headerFontSize,
                        topMargin: headerTopMargin,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: context.percentWidth * 5,
                          right: context.percentWidth * 5,
                        ),
                        height: context.percentWidth * 16,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: cartTopMargin),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.cart.length,
                            itemBuilder: (context, index) {
                              final cartItem = controller.cart[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    right: context.percentWidth * 3),
                                child: FadeInDown(
                                  duration: const Duration(
                                    milliseconds: 600,
                                  ),
                                  child: cartItem.quantity > 1
                                      ? Badge(
                                          badgeColor: AppColors.deepAmber,
                                          animationType:
                                              BadgeAnimationType.scale,
                                          elevation: 0,
                                          badgeContent: cartItem.quantity
                                              .toString()
                                              .text
                                              .white
                                              .make(),
                                          child: Image.asset(
                                            cartItem.book.image,
                                          ),
                                        )
                                      : Image.asset(
                                          cartItem.book.image,
                                        ),
                                ),
                              );
                            }),
                      ),
                      Positioned(
                        top: 160,
                        left: context.percentWidth * 5,
                        right: context.percentWidth * 5,
                        child: const Divider(
                          color: AppColors.green,
                          thickness: 2,
                        ),
                      ),
                      controller.cart.isEmpty
                          ? Positioned(
                              top: context.percentHeight * 40,
                              left: context.percentWidth * 5,
                              right: context.percentWidth * 5,
                              child:
                                  Lottie.asset("assets/images/empty_cart.json"))
                          : Positioned(
                              top: context.percentHeight * 18,
                              left: context.percentWidth * 5,
                              right: context.percentWidth * 5,
                              child: SizedBox(
                                height: context.percentHeight * 70,
                                width: double.infinity,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.cart.length,
                                    itemBuilder: (context, index) {
                                      // final cartItem = controller.cart[index];
                                      return CartCard(
                                        controller: controller,
                                        index: index,
                                      );
                                    }),
                              ),
                            ),
                      if (_swipeUp && controller.cart.isNotEmpty)
                        Positioned(
                          bottom: context.percentHeight * 8,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CountUp(
                              prefix: "Total: ",
                              suffix: " ৳",
                              begin: _begin,
                              end: controller.sumCartPrice().toDouble(),
                              style: TextStyle(
                                  color: AppColors.deepAmber,
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
                      if (_swipeUp && controller.cart.isNotEmpty)
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
                                child: "Checkout"
                                    .text
                                    .bold
                                    .color(AppColors.backgroundWhite)
                                    .xl2
                                    .makeCentered(),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
