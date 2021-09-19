import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '/controller/cart_controller.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);
  final int index;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    final book = controller.cart[index].book;
    final cartItem = controller.cart[index];
    return Dismissible(
      key: ObjectKey(book),
      background: Container(
        margin: EdgeInsets.only(bottom: context.percentWidth * 3),
        padding: EdgeInsets.only(left: context.percentWidth * 3),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.deepAmber,
          borderRadius: BorderRadius.circular(context.percentWidth * 3),
        ),
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.only(bottom: context.percentWidth * 3),
        padding: EdgeInsets.only(right: context.percentWidth * 3),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: AppColors.deepAmber,
          borderRadius: BorderRadius.circular(context.percentWidth * 3),
        ),
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          controller.cart.removeAt(index);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: "The item has been removed from cart".text.make(),
                action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    // controller.cart.insert(index, cartItem);
                    controller.addProductsToCart(book);
                  },
                ),
              ),
            );
        } else if (direction == DismissDirection.startToEnd) {
          controller.cart.removeAt(index);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: "The item has been removed from cart".text.make(),
                action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    // controller.cart.insert(index, cartItem);
                    controller.addProductsToCart(book);
                  },
                ),
              ),
            );
        }
      },
      child: Container(
        padding: EdgeInsets.only(right: context.percentWidth * 3),
        margin: EdgeInsets.only(bottom: context.percentWidth * 3),
        height: context.percentWidth * 25,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.percentWidth * 3)),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.percentWidth * 3),
                  bottomLeft: Radius.circular(context.percentWidth * 3),
                ),
                child: Image.asset(
                  book.image,
                  fit: BoxFit.contain,
                  alignment: Alignment.topLeft,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    controller.cart[index].book.title,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: context.percentWidth * 5,
                    ),
                  ),
                  Text(
                    controller.cart[index].book.author,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: context.percentWidth * 4,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${controller.cart[index].book.normalPrice}",
                            style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                          fontSize: context.percentWidth * 4,
                            ),
                          ),
                          SizedBox(
                            width: context.percentWidth * 4,
                          ),
                          Text(
                            "${controller.cart[index].book.discountedPrice}",
                            style: TextStyle(
                          color: Colors.black,
                          fontSize: context.percentWidth * 4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: context.percentWidth * 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // IconButton(
                            //     onPressed: () {
                            //       print("tapped");
                            //       controller.removeProductsFromCart(cartItem);
                            //       controller.cart.refresh();
                            //     },
                            //     icon: Icon(Icons.remove)),
                            GestureDetector(
                                onTap: () {
                                  controller.removeProductsFromCart(cartItem);
                                  controller.cart.refresh();
                                },
                                child: const Icon(Icons.remove)),
                            cartItem.quantity.toString()
                                .text
                                .size(context.percentWidth * 4)
                                .make(),
                            GestureDetector(
                                onTap: () {
                                  controller.addProductsToCart(book);
                                  controller.cart.refresh();
                                },
                                child: const Icon(Icons.add)),
                          ],
                        ),
                      ),

                      // Icon(
                      //   Icons.favorite,
                      //   color: Colors.red,
                      // )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Container(
//           height: 20,
//           width: 30,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(bottomRight: Radius.circular(
//                 // MediaQuery.of(context).size.width * 0.03,
//                 10), topLeft: Radius.circular(
//                 // MediaQuery.of(context).size.width * 0.03,
//                 10)),
//             color: LightColor.red,
//           ),
//           child: Center(
//               child: Text(
//             '25%',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           )),
//         ),
