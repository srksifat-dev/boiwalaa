import 'package:boiwalaa/controller/cart_controller.dart';
import 'package:boiwalaa/model/book.dart';
import 'package:boiwalaa/view/global_widget/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchScreen extends SearchDelegate<String> {
  final cartController = Get.find<CartController>();
  final List<BookModel> queryList = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
    // throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionBook = query.isEmpty
        ? cartController.recentViews
        : demoBooks
            .where((element) =>
                element.bookName.contains(query) ||
                element.publication.pubName.contains(query))
            .toList();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.percentWidth * 5),
      child: GridView.builder(
          padding: EdgeInsets.only(left: context.percentWidth * 5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            mainAxisSpacing: context.percentHeight * 3,
          ),
          itemCount: suggestionBook.length,
          itemBuilder: (context, index) {
            return productCard(
                context: context, book: suggestionBook[index], duration: index);
          }),
    );
  }
}
