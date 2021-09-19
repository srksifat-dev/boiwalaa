import '/model/book.dart';

class CartItem {
  int quantity;
  final Book book;

  CartItem({
    this.quantity = 1,
    required this.book,
  });
}
