// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '/controller/auth_controller.dart';
// import '/controller/cart_controller.dart';
// import '/controller/order_controller.dart';
// import '/model/order.dart';
// import '/view/theme/colors.dart';

// class SelectDeliveryOption extends StatefulWidget {
//   final TextEditingController country;
//   final TextEditingController state;
//   final TextEditingController city;
//   const SelectDeliveryOption({
//     Key? key,
//     required this.country,
//     required this.state,
//     required this.city,
//   }) : super(key: key);
//   @override
//   _SelectDeliveryOptionState createState() => _SelectDeliveryOptionState();
// }

// class _SelectDeliveryOptionState extends State<SelectDeliveryOption> {
//   final cartController = Get.find<CartController>();
//   final orderController = Get.find<OrderController>();
//   final authController = Get.find<AuthController>();

//   Object reDrawHomeScreen = "homeScreenKey";

//   DeliveryMethod deliveryMethod = DeliveryMethod.scs;
//   DeliveryPlace deliveryPlace = DeliveryPlace.inside;

//   Object? selectedRadio;
//   bool saveAddress = false;

//   @override
//   void initState() {
//     super.initState();
//     selectedRadio = 1;
//   }

//   setSelectedRadio(Object? val) {
//     setState(() {
//       selectedRadio = val;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(
//           children: [
//             Checkbox(
//               activeColor: AppColors.deepRed,
//               value: saveAddress,
//               onChanged: (val) => setState(() => saveAddress = val!),
//             ),
//             "Save address for next time purchase".text.make(),
//           ],
//         ),
//         HeightBox(context.percentHeight * 2),
//         "Select Delivery Option".text.xl2.bold.make(),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Radio(
//                   value: 1,
//                   groupValue: selectedRadio,
//                   activeColor: AppColors.deepRed,
//                   onChanged: (val) {
//                     setSelectedRadio(val);
//                     setState(() {
//                       orderController.deliveryMethod = DeliveryMethod.scs;
//                     });
//                   },
//                 ),
//                 Text("Sundarban Courier Service"),
//               ],
//             ),
//             Row(
//               children: [
//                 Radio(
//                   value: 2,
//                   groupValue: selectedRadio,
//                   activeColor: AppColors.deepRed,
//                   onChanged: (val) {
//                     setSelectedRadio(val);
//                     setState(() {
//                       orderController.deliveryMethod = DeliveryMethod.cod;
//                     });
//                   },
//                 ),
//                 Text("Cash on delivery"),
//               ],
//             ),
//           ],
//         ),
//         HeightBox(context.percentHeight * 2),
//         Row(
//           children: [
//             Container(
//               padding: EdgeInsets.all(0),
//               width: MediaQuery.of(context).size.width * 0.62,
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   hintText: "Promo Code",
//                   filled: true,
//                   fillColor: AppColors.deepRed.withOpacity(0.2),
//                   contentPadding: EdgeInsets.symmetric(
//                       horizontal: context.percentWidth * 5,
//                       vertical: context.percentWidth * 3),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: AppColors.deepRed),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: AppColors.deepRed),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                   height: context.percentHeight * 5.4,
//                   decoration: BoxDecoration(
//                       // borderRadius: BorderRadius.only(
//                       //   topRight: Radius.circular(
//                       //     context.percentWidth * 3,
//                       //   ),
//                       //   bottomRight: Radius.circular(
//                       //     context.percentWidth * 3,
//                       //   ),
//                       //   topLeft: Radius.circular(
//                       //     0,
//                       //   ),
//                       //   bottomLeft: Radius.circular(
//                       //     0,
//                       //   ),
//                       // ),
//                       color: AppColors.deepRed),
//                   child: Center(
//                     child: Text(
//                       'Apply',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: context.percentWidth * 5,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )),
//             ),
//           ],
//         ),
//         HeightBox(context.percentHeight * 2),
//         Container(
//           height: context.percentWidth * 50,
//           decoration: BoxDecoration(
//             border: Border.all(
//                 color: AppColors.deepRed, width: 2, style: BorderStyle.solid),
//             borderRadius: BorderRadius.all(
//               Radius.circular(context.percentWidth * 3),
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(context.percentWidth * 3),
//                 child: Container(
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Total: ',
//                             style: TextStyle(
//                               color: AppColors.deepRed,
//                               fontSize: context.percentWidth * 4,
//                             ),
//                           ),
//                           Text(
//                             'Tk.${cartController.sumCartPrice()}',
//                             style: TextStyle(
//                               color: AppColors.deepRed,
//                               fontSize: context.percentWidth * 4,
//                             ),
//                           )
//                         ],
//                       ),
//                       Divider(
//                         color: AppColors.deepRed,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Delivery Charge: ',
//                             style: TextStyle(
//                               color: AppColors.deepRed,
//                               fontSize: context.percentWidth * 4,
//                             ),
//                           ),
//                           Text(
//                             'Tk.${orderController.deliveryCharge(widget.state.text == "Dhaka" || widget.state.text == "dhaka" ? DeliveryPlace.inside : DeliveryPlace.outside, orderController.deliveryMethod).toString()}',
//                             style: TextStyle(
//                               color: AppColors.deepRed,
//                               fontSize: context.percentWidth * 4,
//                             ),
//                           ),
//                         ],
//                       ),
//                       // Divider(
//                       //   color: AppColors.deepRed,
//                       // ),
//                       // Row(
//                       //   mainAxisAlignment:
//                       //       MainAxisAlignment.spaceBetween,
//                       //   children: [
//                       //     Text(
//                       //       'Gift Charge: ',
//                       //       style: TextStyle(
//                       //         color: AppColors.deepRed,
//                       //         fontSize:
//                       //             context.percentWidth * 4,
//                       //       ),
//                       //     ),
//                       //     Text(
//                       //       'Tk.100',
//                       //       style: TextStyle(
//                       //         color: AppColors.deepRed,
//                       //         fontSize:
//                       //             context.percentWidth * 4,
//                       //       ),
//                       //     )
//                       //   ],
//                       // ),
//                       Divider(
//                         color: AppColors.deepRed,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Promo Code Discount: ',
//                             style: TextStyle(
//                               color: AppColors.deepRed,
//                               fontSize: context.percentWidth * 4,
//                             ),
//                           ),
//                           Text(
//                             '-Tk.0',
//                             style: TextStyle(
//                               color: AppColors.deepRed,
//                               fontSize: context.percentWidth * 4,
//                             ),
//                           )
//                         ],
//                       ),
//                       Divider(
//                         color: AppColors.deepRed,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Payable Total: ',
//                             style: TextStyle(
//                               color: AppColors.deepRed,
//                               fontSize: context.percentWidth * 4,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Tk.${cartController.sumCartPrice() + orderController.deliveryCharge(widget.state == "Dhaka" || widget.state == "dhaka" ? DeliveryPlace.inside : DeliveryPlace.outside, orderController.deliveryMethod)}',
//                             style: TextStyle(
//                               color: AppColors.deepRed,
//                               fontSize: context.percentWidth * 4,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Container(
//               //   decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.only(
//               //         bottomRight: Radius.circular(context.percentWidth * 2),
//               //         bottomLeft: Radius.circular(context.percentWidth * 2)),
//               //     color: LightColor.customAmber,
//               //   ),
//               //   height:context.percentWidth * 11,
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //     children: [
//               //       GestureDetector(
//               //         onTap: () => Get.to(GiftShipmentInfoScreen()),
//               //         child: Container(
//               //           child: Center(
//               //             child: Text(
//               //               'Continue to Gift',
//               //               style: TextStyle(
//               //                 fontWeight: FontWeight.bold,
//               //                 color: AppColors.deepRed,
//               //                 fontSize: context.percentWidth * 5,
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //       ),
//               //       VerticalDivider(
//               //         color: AppColors.deepRed,
//               //         thickness: 2,
//               //       ),
//               //       GestureDetector(
//               //         onTap: () => Get.to(ShipmentInfoScreen()),
//               //         child: Container(
//               //           child: Center(
//               //             child: Text(
//               //               'Continue to Next',
//               //               style: TextStyle(
//               //                 fontWeight: FontWeight.bold,
//               //                 color: AppColors.deepRed,
//               //                 fontSize: context.percentWidth * 5,
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//         HeightBox(context.percentHeight * 2),
//         TextFormField(
//           decoration: InputDecoration(
//             hintText: "Transaction ID(Bkash/Rocket/Nagad) ",
//             filled: true,
//             fillColor: AppColors.deepRed.withOpacity(0.2),
//             contentPadding: EdgeInsets.symmetric(
//                 horizontal: context.percentWidth * 5,
//                 vertical: context.percentWidth * 3),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: AppColors.deepRed),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: AppColors.deepRed),
//             ),
//           ),
//         ),
//         HeightBox(context.percentHeight * 1),
//         "* Send Money to Bkash personal(01620535560)/ Rocket personal(01620535560)/ Nagad personal(01620535560)"
//             .text
//             .gray500
//             .make(),
//         HeightBox(context.percentHeight * 8),
//       ],
//     );
//   }
// }
