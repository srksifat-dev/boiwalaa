import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:boiwalaa/controller/cart_controller.dart';
import 'package:boiwalaa/model/book.dart';
import 'package:boiwalaa/view/detail_screen/new_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productCard({
  required BuildContext context,
  required BookModel book,
  required int duration,
}) {
  var screenWidth = MediaQuery.of(context).size.width;
  final cartController = Get.find<CartController>();
  return FadeInDown(
    duration: const Duration(milliseconds: 500),
    delay: Duration(milliseconds: (duration * 50)),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (_) => DetailsScreen(book: book)));
        cartController.addProductsToRecentViews(book);
      },
      child: Stack(
        children: [
          Container(
            height: context.percentWidth * 47,
            width: screenWidth * 0.25,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(screenWidth * 0.03)),
                color: Colors.grey[200]),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenWidth * 0.03),
                        topRight: Radius.circular(screenWidth * 0.03)),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(book.image),
                        // Image.network(
                        //   book.image,
                        //   errorBuilder: (context, _, __) {
                        //     return "Refresh the page".text.makeCentered();
                        //   },
                        // ),
                        Container(
                          height: context.percentWidth * 15,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.black.withOpacity(0),
                                Colors.black
                              ])),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                book.bookName,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: context.percentWidth * 23,
                                height: 15,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: book.authors.length,
                                  itemBuilder: (context, index) => AutoSizeText(
                                    book.authors[index].authorName,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              HeightBox(context.percentWidth * 1)
                            ],
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: screenWidth * 0.01,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.percentWidth * 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${book.discountedPercent.toString()}৳",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                            onTap: () => cartController.addProductsToCart(book),
                            child: const Icon(Icons.add_circle)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: screenWidth * 0.06,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(
                  // MediaQuery.of(context).size.width * 0.03,
                  10), topLeft: Radius.circular(
                  // MediaQuery.of(context).size.width * 0.03,
                  10)),
              color: Colors.red,
            ),
            child: Text(
              "-${(100 - ((book.discountedPercent * 100) / book.normalPrice)).toStringAsFixed(0)}%",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
