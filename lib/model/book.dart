import 'package:boiwalaa/model/author.dart';
import 'package:boiwalaa/model/category.dart';
import 'package:boiwalaa/model/review.dart';

import 'publication.dart';

enum CoverType {
  paperBack,
  hardCover,
}

enum Language { bangla, english }

class BookModel {
  const BookModel({
    required this.bookId,
    required this.bookName,
    required this.authors,
    this.translators,
    required this.image,
    required this.normalPrice,
    required this.discountedPercent,
    required this.description,
    required this.categories,
    required this.publication,
    this.coverType = CoverType.paperBack,
    this.language = Language.bangla,
    this.edition = "",
    this.isbnNumber = "",
    this.soldQuantity = 0,
    this.reviews,
    this.addedTime,
    this.pageNumber = 0,
    this.stock = 5,
  });
  final String bookId;
  final String bookName;
  final List<AuthorModel> authors;
  final List<AuthorModel>? translators;
  final String image;
  final int normalPrice;
  final int discountedPercent;
  final String description;
  final List<CategoryModel> categories;
  final PublicationModel publication;
  final CoverType coverType;
  final Language language;
  final String edition;
  final String isbnNumber;
  final int soldQuantity;
  final List<ReviewModel>? reviews;
  final DateTime? addedTime;
  final int pageNumber;
  final int stock;
}

final List<CategoryModel> categoryList = [
  CategoryModel(title: "Bangla"),
  CategoryModel(title: "English"),
  CategoryModel(title: "Computer"),
  CategoryModel(title: "Programming"),
  CategoryModel(title: "History"),
  CategoryModel(title: "Drama"),
  CategoryModel(title: "Romantic"),
  CategoryModel(title: "Motivation"),
  CategoryModel(title: "Social")
];

final List<PublicationModel> publicationList = [
  PublicationModel(pubName: "Adorsho Publication"),
  PublicationModel(pubName: "Profile Publication"),
  PublicationModel(pubName: "Swore-o Publication"),
  PublicationModel(pubName: "Somokalin Publication"),
];

// void addToCategoryList(Book book) {
//   for (Book book in demoBooks) {
//     if (book.category == book.category) {
//       return;
//     } else {
//       categoryList.add(book.category);
//       print(categoryList);
//     }
//   }
// }

final demoBooks = [
  BookModel(
    bookId: "1",
    bookName: "১ মিনিটে ইংরেজি",
    authors: [AuthorModel(authorName: "এনামুল কবীর সরকার")],
    image: "assets/images/1-minte.jpg",
    normalPrice: 300,
    discountedPercent: 250,
    description: "This is a nice book.",
    categories: [
      CategoryModel(title: "Bangla"),
    ],
    publication: PublicationModel(pubName: "Adorsho Publication"),
  ),
  BookModel(
    bookId: "2",
    bookName: "গ্রে লেডি অব বাগরাম",
    authors: [AuthorModel(authorName: "আফিয়া সিদ্দিকী")],
    image: "assets/images/Aafia-front.jpg",
    normalPrice: 300,
    discountedPercent: 234,
    description: "This is a nice book.",
    categories: [
      CategoryModel(title: "Bangla"),
    ],
    publication: PublicationModel(pubName: "Adorsho Publication"),
  ),
  BookModel(
    bookId: "3",
    bookName: "কালকের আন্দোলন, আজকের আন্দোলন",
    authors: [AuthorModel(authorName: "অনুপম দেবাশীষ রায়")],
    image: "assets/images/ajker-andolon.png",
    normalPrice: 300,
    discountedPercent: 204,
    description: "This is a nice book",
    categories: [
      CategoryModel(title: "Bangla"),
    ],
    publication: PublicationModel(pubName: "Adorsho Publication"),
  ),
  BookModel(
    bookId: "4",
    bookName: "এখানে আকাশ নীল",
    authors: [AuthorModel(authorName: "রবিউল করিম মৃদুল")],
    image: "assets/images/Akhane-akash-nil.png",
    normalPrice: 300,
    discountedPercent: 240,
    description: "This is a nice book.",
    categories: [
      CategoryModel(title: "Bangla"),
    ],
    publication: PublicationModel(pubName: "Adorsho Publication"),
  ),
  BookModel(
    bookId: "5",
    bookName: "একটু গভিরে এসো",
    authors: [AuthorModel(authorName: "নবায়ন পারভেজ")],
    image: "assets/images/Aktu-gobare-aso.jpg",
    normalPrice: 400,
    discountedPercent: 240,
    description: "This is a nice book.",
    categories: [
      CategoryModel(title: "Bangla"),
    ],
    publication: PublicationModel(pubName: "Adorsho Publication"),
  ),
  BookModel(
    bookId: "6",
    bookName: "অ্যালগরিদম ডিজাইন",
    authors: [AuthorModel(authorName: "অরিন্দম পাল")],
    image: "assets/images/Algoridom-Design-1-1.jpg",
    normalPrice: 230,
    discountedPercent: 180,
    description: "This is a nice book.",
    categories: [
      CategoryModel(title: "Bangla"),
    ],
    publication: PublicationModel(pubName: "Adorsho Publication"),
  ),
  BookModel(
    bookId: "7",
    bookName: "পানকৌড়ির রক্ত",
    authors: [AuthorModel(authorName: "আল মাহমুদ")],
    image: "assets/images/pankari.jpg",
    normalPrice: 240,
    discountedPercent: 220,
    description: "This is a nice book.",
    categories: [
      CategoryModel(title: "English"),
    ],
    publication: PublicationModel(pubName: "Profile Publication"),
  ),
  BookModel(
    bookId: "8",
    bookName: "অ্যাম্বাসেডর",
    authors: [AuthorModel(authorName: "আবদুস সালাম জাইফ")],
    image: "assets/images/Ambassador-Front.jpg",
    normalPrice: 180,
    discountedPercent: 150,
    description: "This is a nice book",
    categories: [
      CategoryModel(title: "English"),
    ],
    publication: PublicationModel(pubName: "Profile Publication"),
  ),
  BookModel(
    bookId: "9",
    bookName: "এটিচিউড ইজ এভরিথিং",
    authors: [AuthorModel(authorName: "ত্বাইরান আবির")],
    image: "assets/images/Attitude-Is-Everything-Front.jpg",
    normalPrice: 230,
    discountedPercent: 180,
    description: "This is a nice book.",
    categories: [
      CategoryModel(title: "English"),
    ],
    publication: PublicationModel(pubName: "Profile Publication"),
  ),
  BookModel(
    bookId: "10",
    bookName: "আয়না",
    authors: [AuthorModel(authorName: "আফজাল গুরু")],
    image: "assets/images/Ayna-Front.jpg",
    normalPrice: 120,
    discountedPercent: 100,
    description: "This is a nice book.",
    categories: [
      CategoryModel(title: "English"),
    ],
    publication: PublicationModel(pubName: "Profile Publication"),
  ),
  BookModel(
    bookId: "11",
    bookName: "আজাদির লড়াই",
    authors: [AuthorModel(authorName: "মুহাম্মদ নাফিস নাওয়ার")],
    image: "assets/images/Azadi-Front.jpg",
    normalPrice: 230,
    discountedPercent: 190,
    description: "This is a nice book.",
    categories: [
      CategoryModel(title: "Social"),
    ],
    publication: PublicationModel(pubName: "Somokalin Publication"),
  )
];
