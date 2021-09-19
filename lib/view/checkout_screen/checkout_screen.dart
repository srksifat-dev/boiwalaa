import '/view/checkout_screen/flip_card.dart';
import 'package:flutter/material.dart';

Future showCheckoutDialog(BuildContext context) {

  return showGeneralDialog(
      context: context,
      pageBuilder: (
        BuildContext context,
        Animation animation,
        Animation secondAnimation,
      ) {
        return const Material(color: Colors.transparent, child: FlipCard()
            // Stack(
            //   alignment: Alignment.topCenter,
            //   children: [
            //     Positioned(
            //       top: context.percentHeight * 27,
            //       child: ElasticIn(
            //         duration: Duration(milliseconds: 1000),
            //         child: FlipCard(state: state),
            // Container(
            //   height: context.percentHeight * 63,
            //   width: context.percentWidth * 90,
            //   decoration: BoxDecoration(
            //     color: AppColors.lightRed,
            //     borderRadius:
            //         BorderRadius.circular(context.percentWidth * 5),
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.only(
            //       left: context.percentWidth * 5,
            //       right: context.percentWidth * 5,
            //       top: context.percentWidth * 6,
            //     ),
            //     child: FlipCard(state: state),
            //   ),
            // ),
            //   ),
            // ),
            //       Positioned(
            //           bottom: context.percentHeight * 10,
            //           left: context.percentWidth * 5,
            //           right: context.percentWidth * 5,
            //           child: ElasticIn(
            //             duration: Duration(milliseconds: 1000),
            //             child: GestureDetector(
            //               onTap: () {
            //                 Get.back();
            //                 cartController.cart.clear();
            //                 cartController.cart.refresh();
            //                 Fluttertoast.showToast(
            //                     msg:
            //                         "Your order has been placed. Wait behind the door to get it!",
            //                     toastLength: Toast.LENGTH_LONG,
            //                     gravity: ToastGravity.CENTER,
            //                     timeInSecForIosWeb: 1,
            //                     // backgroundColor: AppColors.deepRed,
            //                     textColor: Colors.white,
            //                     fontSize: 16.0);
            //               },
            //               child: Container(
            //                   decoration: BoxDecoration(
            //                       color: AppColors.deepRed,
            //                       borderRadius: BorderRadius.circular(
            //                         context.percentWidth * 5,
            //                       )),
            //                   height: context.percentWidth * 14,
            //                   width: context.percentWidth * 90,
            //                   child: TextButton(
            //                       onPressed: () {
            //                         final List<CartItem> orders = [];
            //                         final f = DateFormat("yyyy-MM-dd hh:mm");
            //                         final dateTime = f.format(DateTime.now());
            //                         for (CartItem cartItem in cartController.cart) {
            //                           orders.add(cartItem);
            //                         }
            //                         final orderItem = OrderItem(
            //                           deliveryMethod: orderController.deliveryMethod,
            //                           country: country.text,
            //                           state: state.text,
            //                           city: city.text,
            //                           totalPrice: cartController.sumCartPrice(),
            //                           orderID: "BO#${orderID()}",
            //                           cartItem: orders,
            //                           orderTime: dateTime,
            //                         );
            //                         orderController.addOrder(orderItem);

            //                         Get.back();
            //                         cartController.cart.clear();
            //                         cartController.cart.refresh();
            //                         orderController.deliveryMethod =
            //                             DeliveryMethod.scs;
            //                         Fluttertoast.showToast(
            //                             msg:
            //                                 "Your order has been placed. Wait behind the door to get it!",
            //                             toastLength: Toast.LENGTH_LONG,
            //                             gravity: ToastGravity.CENTER,
            //                             timeInSecForIosWeb: 1,
            //                             // backgroundColor: AppColors.deepRed,
            //                             textColor: Colors.white,
            //                             fontSize: 16.0);
            //                       },
            //                       child: "Confirm Order"
            //                           .text
            //                           .color(AppColors.backgroundWhite)
            //                           .xl2
            //                           .makeCentered())),
            //             ),
            //           )),
            //       Positioned(
            //         bottom: context.percentHeight * 3,
            //         child: ElasticIn(
            //           duration: Duration(milliseconds: 1000),
            //           child: GestureDetector(
            //             onTap: () {
            //               orderController.deliveryMethod = DeliveryMethod.scs;
            //               Get.back();
            //             },
            //             child: CircleAvatar(
            //               backgroundColor: Colors.white.withOpacity(0.5),
            //               radius: 20,
            //               child: Center(
            //                 child: Icon(
            //                   Icons.close,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // );
            // },
            );
      });
}
