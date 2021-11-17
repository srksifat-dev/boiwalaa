import 'package:boiwalaa/controller/cart_controller.dart';
import 'package:boiwalaa/view/detail_screen/product_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:boiwalaa/model/book.dart';

import 'detail_widget.dart';

class DetailsScreen extends StatelessWidget {
  final cartController = Get.find<CartController>();
  final BookModel book;
  DetailsScreen({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: book.bookName.text.black.make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline))
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                // color: LightColor.background,
                gradient: LinearGradient(
                  colors: [
                    Color(0xfffbfbfb),
                    Color(0xfff7f7f7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ProductImage(book: book),
                      // _categoryWidget(),
                    ],
                  ),
                  detailWidget(context, book)
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => cartController.addProductsToCart(book),
                child: Container(
                  height: context.percentWidth * 15,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Center(
                      child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: context.percentWidth * 6,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
