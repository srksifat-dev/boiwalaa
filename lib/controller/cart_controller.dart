import '/model/book.dart';
import '/model/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cart = List<CartItem>.empty(growable: true).obs;
  var recentViews = List<Book>.empty(growable: true).obs;

  int sumCartPrice() {
    return cart.fold(
        0,
        (previousValue, element) =>
            previousValue + element.book.discountedPrice * element.quantity);
  }

  int sumCartQuantity() {
    return cart.fold(
        0, (previousValue, element) => previousValue + element.quantity);
  }

  RxInt cartItemQuantity(CartItem cartItem) {
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

  void addProductsToCart(Book book) {
    for (CartItem cartItem in cart) {
      if (cartItem.book.bookId == book.bookId) {
        cartItem.quantity++;
        return;
      }
    }
    cart.add(CartItem(book: book));
  }

  void removeProductsFromCart(CartItem cartItem) {
    if (cartItem.quantity == 1) {
      return;
    } else {
      cartItem.quantity--;
    }
  }

  void deleteProductFromCart(Book book) {
    for (CartItem cartItem in cart) {
      if (cartItem.book.bookId == book.bookId) {
        cart.remove(book);
      }
    }
  }

  void addProductsToRecentViews(Book book) {
    for (Book recentViewsBook in recentViews) {
      if (recentViewsBook.bookId == book.bookId) {
        return;
      } else if (recentViews.length == 5) {
        recentViews.removeLast();
        recentViews.add(book);
      }
    }
    recentViews.add(book);
  }
}
