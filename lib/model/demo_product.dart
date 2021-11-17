import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


class Product {
  final String? productId;
  final String? bookName;
  final String? authorName;
  final String? categories;
  String? imageUrl = 'https://drive.google.com/file/d/1ijuh0859H4CophA5sLnBVwP-W90xoVzt/view?usp=sharing';
  final int? normalPrice;
  final int? discountPercent;
  final String? description;
  final String? coverType;
  final String? publisher;
  final String? language;
  bool? isFavorite = false;
  DateTime? addedTime = DateTime.now();
  final String? isbnNumber;
  final String? edition;
  final int? pageNumber;
  final int? stock;
  Product({
    @required this.productId,
    @required this.bookName,
    @required this.authorName,
    @required this.categories,
    @required this.normalPrice,
    @required this.discountPercent,
    this.isFavorite,
    this.imageUrl,
    @required this.coverType,
    @required this.description,
    @required this.language,
    @required this.publisher,
    this.addedTime,
    this.isbnNumber,
    @required this.edition,
    @required this.pageNumber,
    @required this.stock,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'bookName': bookName,
      'authorName': authorName,
      'categories': categories,
      'imageUrl': imageUrl,
      'normalPrice': normalPrice,
      'discountPercent': discountPercent,
      'description': description,
      'coverType': coverType,
      'publisher': publisher,
      'language': language,
      'isFavorite': isFavorite,
      'addedTime': FieldValue.serverTimestamp(),
      'isbnNumber': isbnNumber,
      'edition': edition,
      'pageNumber': pageNumber,
      'stock': stock,
    };
  }

  Product.fromFirestore(DocumentSnapshot firestore)
      : productId = firestore['productId'],
        bookName = firestore['bookName'],
        authorName = firestore['authorName'],
        categories = firestore['categories'],
        imageUrl = firestore['imageUrl'],
        normalPrice = firestore['normalPrice'],
        discountPercent = firestore['discountPercent'],
        description = firestore['description'],
        coverType = firestore['coverType'],
        publisher = firestore['publisher'],
        language = firestore['language'],
        isFavorite = firestore['isFavorite'],
        addedTime = firestore['addedTime'],
        isbnNumber = firestore['isbnNumber'],
        edition = firestore['edition'],
        pageNumber = firestore['pageNumber'],
        stock = firestore['stock'];
}
