import 'package:animate_do/animate_do.dart';
import '/model/book.dart';
import '/controller/cart_controller.dart';
import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Future showDetailDialog(BuildContext context, BookModel book) {
  final controller = Get.put(CartController());

  return showGeneralDialog(
      context: context,
      pageBuilder: (
        BuildContext context,
        Animation animation,
        Animation secondAnimation,
      ) {
        return DefaultTabController(
          length: 3,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: context.percentHeight * 27,
                  child: ElasticIn(
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      height: context.percentHeight * 63,
                      width: context.percentWidth * 90,
                      decoration: BoxDecoration(
                        color: AppColors.lightAmber,
                        borderRadius:
                            BorderRadius.circular(context.percentWidth * 5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: context.percentWidth * 5,
                          right: context.percentWidth * 5,
                          top: context.percentWidth * 6,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            HeightBox(context.percentHeight * 3),
                            ElasticIn(
                                duration: const Duration(milliseconds: 1000),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: context.percentWidth * 80,
                                  height: 30,
                                  child: Text(
                                    book.bookName,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: context.percentWidth * 6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            10.heightBox,
                            ElasticIn(
                                duration: const Duration(milliseconds: 1000),
                                child: "by ${book.authors}"
                                    .text
                                    .xl2
                                    .color(Colors.grey)
                                    .make()),
                            10.heightBox,
                            ElasticIn(
                              duration: const Duration(milliseconds: 1000),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  "${book.normalPrice}"
                                      .text
                                      .red500
                                      .xl3
                                      .textStyle(const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough))
                                      .make(),
                                  10.widthBox,
                                  "${book.discountedPercent}".text.xl3.make()
                                ],
                              ),
                            ),
                            TabBar(
                                indicatorColor: AppColors.deepAmber,
                                tabs: [
                                  ElasticIn(
                                    duration: const Duration(milliseconds: 1000),
                                    child: Tab(
                                      child: "Description".text.black.make(),
                                    ),
                                  ),
                                  ElasticIn(
                                    duration: const Duration(milliseconds: 1000),
                                    child: Tab(
                                      child: "Details".text.black.make(),
                                    ),
                                  ),
                                  ElasticIn(
                                    duration: const Duration(milliseconds: 1000),
                                    child: Tab(
                                      child: "Reviews".text.black.make(),
                                    ),
                                  ),
                                ]),
                            Container(
                              padding: EdgeInsets.only(
                                  top: context.percentWidth * 5),
                              height: context.percentHeight * 35,
                              width: double.infinity,
                              child: ElasticIn(
                                duration: const Duration(milliseconds: 1000),
                                child: TabBarView(children: [
                                  book.description.text.make(),
                                  book.description.text.make(),
                                  book.description.text.make(),
                                ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: context.percentHeight * 10,
                    left: context.percentWidth * 5,
                    right: context.percentWidth * 5,
                    child: ElasticIn(
                      duration: const Duration(milliseconds: 1000),
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.deepAmber,
                              borderRadius: BorderRadius.circular(
                                context.percentWidth * 5,
                              )),
                          height: context.percentWidth * 14,
                          width: context.percentWidth * 90,
                          child: TextButton(
                              onPressed: () {
                                Get.back();
                                controller.addProductsToCart(book);
                              },
                              child: "Add to Cart"
                                  .text
                                  .color(AppColors.backgroundWhite)
                                  .xl2
                                  .makeCentered())),
                    )),
                Positioned(
                  top: context.percentHeight * 10,
                  child: ElasticIn(
                    duration: const Duration(milliseconds: 1000),
                    child: Image.asset(
                      book.image,
                      height: 200,
                    ),
                  ),
                ),
                Positioned(
                  bottom: context.percentHeight * 3,
                  child: ElasticIn(
                    duration: const Duration(milliseconds: 1000),
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.5),
                        radius: 20,
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      // Dialog(
      //       elevation: 0,
      //       backgroundColor:
      //           Colors.transparent,
      //       child: Container(
      //         height: context
      //                 .percentHeight *
      //             100,
      //         width:
      //             double.infinity,
      //         child: Stack(
      //           alignment: Alignment
      //               .topCenter,
      //           children: [
      //             Positioned(
      //               top: context
      //                       .percentHeight *
      //                   10,
      //               child:
      //                   Container(
      //                 height: context
      //                         .percentHeight *
      //                     50,
      //                 width: context
      //                         .percentWidth *
      //                     68,
      //                 decoration: BoxDecoration(
      //                     color: AppColors()
      //                         .backgroundWhite,
      //                     borderRadius:
      //                         BorderRadius.circular(context.percentWidth *
      //                             5)),
      //               ),
      //             ),
      //             Hero(
      //               tag:
      //                   "cartImage",
      //               child:
      //                   Image.asset(
      //                 book.image,
      //                 height: 200,
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     )
      );
}
