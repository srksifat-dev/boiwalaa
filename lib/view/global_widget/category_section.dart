// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:velocity_x/velocity_x.dart';

// import 'product_card_vertical.dart';

// Widget categorySection(BuildContext context) {
//   return SizedBox(
//     height: context.percentHeight * 30,
//     width: double.infinity,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: context.percentWidth * 5),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(context.percentWidth * 3),
//             color: Colors.grey[200],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               "Recommended Products"
//                   .text
//                   .xl2
//                   .bold
//                   .make()
//                   .py(context.percentWidth * 3)
//                   .px(context.percentWidth * 5),
//               "See all >"
//                   .text
//                   .color(Colors.blue)
//                   .make()
//                   .px(context.percentWidth * 5)
//             ],
//           ),
//         ),
//         HeightBox(context.percentHeight * 2),
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 5),
//             child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 addAutomaticKeepAlives: true,
//                 itemBuilder: (context, index) {
//                   return productCard(context: context);
//                 },
//                 separatorBuilder: (context, index) {
//                   return WidthBox(context.percentWidth * 3);
//                 },
//                 itemCount: 10),
//           ),
//         ),
//       ],
//     ),
//   );
// }
