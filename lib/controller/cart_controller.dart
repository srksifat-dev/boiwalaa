import 'package:fluttertoast/fluttertoast.dart';

import '/model/book.dart';
import '/model/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cart = List<CartItemModel>.empty(growable: true).obs;
  var demoList = List.empty(growable: true).obs;

  var recentViews = List<BookModel>.empty(growable: true).obs;

  int sumCartPrice() {
    return cart.fold(
        0,
        (previousValue, element) =>
            previousValue + element.book.discountedPercent * element.quantity);
  }

  RxInt sumCartQuantity() {
    return cart.fold(
        0.obs, (previousValue, element) => previousValue + element.quantity);
  }

  RxInt cartItemQuantity(CartItemModel cartItem) {
    return cartItem.quantity.obs;
  }

  // bool isExistsInCart(Book book) {
  //   for (CartItem cartItem in cart) {
  //     if (cartItem.book.bookId == book.bookId) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  void addProductsToCart(BookModel book) {
    for (CartItemModel cartItem in cart) {
      if (cartItem.book.bookId == book.bookId) {
        cartItem.quantity++;
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT,
            msg: "Another copy has been added");
        return;
      }
    }
    cart.add(CartItemModel(book: book));
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_SHORT, msg: "Book has been added to cart");
  }

  void removeProductsFromCart(CartItemModel cartItem) {
    if (cartItem.quantity == 1) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: "Item quantity must not be 0! LOL");
      return;
    } else {
      cartItem.quantity--;
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: "Book has been removed from cart");
    }
  }

  void deleteProductFromCart(BookModel book) {
    for (CartItemModel cartItem in cart) {
      if (cartItem.book.bookId == book.bookId) {
        cart.remove(book);
      }
    }
  }

  void addProductsToRecentViews(BookModel book) {
    for (BookModel recentViewsBook in recentViews) {
      if (recentViewsBook.bookId == book.bookId) {
        return;
      } else if (recentViews.length == 6) {
        recentViews.removeLast();
        recentViews.add(book);
      }
    }
    recentViews.add(book);
  }
}
