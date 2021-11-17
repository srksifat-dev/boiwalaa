import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:boiwalaa/model/book.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({
    Key? key,
    required this.book,
  }) : super(key: key);

  final BookModel book;

  @override
  _ProductImageState createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage>
    with SingleTickerProviderStateMixin {
  bool isLiked = true;
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // AnimatedBuilder(
        //   animation: animation,
        //   builder: (context, child) {
        //     return AnimatedOpacity(
        //       opacity: animation.value,
        //       duration: Duration(milliseconds: 500),
        //       child: child,
        //     );
        //   },
        //   child:
        Center(
      child: Padding(
        padding: EdgeInsets.only(top: context.percentWidth * 3),
        child: SlideInLeft(
          duration: Duration(milliseconds: 300),
          child: Image.asset(
            widget.book.image,
            fit: BoxFit.contain,
            width: context.percentWidth * 45,
          ),
        ),
      ),
      // ),
    );
  }
}
