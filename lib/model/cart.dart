import '/model/book.dart';

class CartItemModel {
  int quantity;
  final BookModel book;

  CartItemModel({
    this.quantity = 1,
    required this.book,
  });
}
