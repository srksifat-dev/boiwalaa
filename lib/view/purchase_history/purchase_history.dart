// import 'package:big_shelf/controller/order_controller.dart';
// import 'package:big_shelf/view/purchase_history/purchase_timeline.dart';
// import 'package:big_shelf/view/theme/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:velocity_x/velocity_x.dart';

// class PurchaseHistory extends StatelessWidget {
//   PurchaseHistory({Key? key}) : super(key: key);

//   final orderController = Get.find<OrderController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.green,
//         title: "Purchase History".text.make(),
//       ),
//       body: orderController.orderList.length == 0
//           ? Center(
//               child: Column(
//                 children: [
//                   Lottie.asset("assets/images/purchase_history.json"),
//                   "You didn't purchase any book from us:(".text.xl2.bold.make(),
//                 ],
//               ),
//             )
//           : Container(
//               height: double.infinity,
//               width: double.infinity,
//               child: ListView.builder(
//                 itemCount: orderController.orderList.length,
//                 itemBuilder: (context, index) {
//                   return PurchaseTimeline();
//                 },
//               ),
//             ),
//     );
//   }
// }
