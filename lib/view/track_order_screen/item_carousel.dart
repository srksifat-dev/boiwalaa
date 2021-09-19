import '/view/theme/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '/model/cart.dart';

class ItemCarousel extends StatefulWidget {
  const ItemCarousel({
    Key? key,
    required this.cartItems,
  }) : super(key: key);
  final List<CartItem> cartItems;

  @override
  _ItemCarouselState createState() => _ItemCarouselState();
}

class _ItemCarouselState extends State<ItemCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
              enlargeCenterPage: true,
              height: context.percentWidth * 25,
              autoPlay: true,
              enableInfiniteScroll: true,
              onPageChanged: (index, _) {
                setState(() {
                  _current = index;
                });
              }),
          itemCount: widget.cartItems.length,
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return Container(
              padding: EdgeInsets.only(right: context.percentWidth * 5),
              // margin: EdgeInsets.symmetric(
              //     horizontal: context.percentWidth * 5),
              height: context.percentWidth * 25,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius:
                      BorderRadius.circular(context.percentWidth * 3)),
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
                        widget.cartItems[itemIndex].book.image,
                        fit: BoxFit.contain,
                        alignment: Alignment.topLeft,
                      ),
                    ),
                  ),
                  WidthBox(context.percentWidth * 2),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          widget.cartItems[itemIndex].book.title,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: context.percentWidth * 5,
                          ),
                        ),
                        Text(
                          widget.cartItems[itemIndex].book.author,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: context.percentWidth * 4,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.cartItems[itemIndex].book.discountedPrice}",
                              style: TextStyle(
                            color: Colors.black,
                            fontSize: context.percentWidth * 4,
                              ),
                            ),
                            "x${widget.cartItems[itemIndex].quantity.toString()}"
                                .text
                                .size(context.percentWidth * 4)
                                .make(),

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
            );
          },
        ),
        HeightBox(context.percentWidth * 2),
        SizedBox(
          height: context.percentWidth * 5,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.cartItems.map((e) {
              int index = widget.cartItems.indexOf(e);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(right: context.percentWidth * 1),
                height: 10,
                width: _current == index ? 30 : 10,
                decoration: BoxDecoration(
                    color: _current == index
                        ? AppColors.deepAmber
                        : AppColors.mediumAmber,
                    borderRadius: BorderRadius.circular(5)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
