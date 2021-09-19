class Book {
  const Book({
    required this.bookId,
    required this.title,
    required this.author,
    required this.image,
    required this.normalPrice,
    required this.discountedPrice,
    required this.description,
    required this.category,
    required this.publication,
  });
  final String bookId;
  final String title;
  final String author;
  final String image;
  final int normalPrice;
  final int discountedPrice;
  final String description;
  final String category;
  final String publication;
}

final List<String> categoryList = [
  "Bangla",
  "English",
  "Computer",
  "Programming",
  "History",
  "Drama",
  "Romantic",
  "Motivation",
  "Social"
];

final List<String> publicationList = [
  "Adorsho Publication",
  "Profile Publication",
  "Swore-o Publication",
  "Somokalin Publication",
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

final demoBooks = const [
  Book(
    bookId: "1",
    title: "১ মিনিটে ইংরেজি",
    author: "এনামুল কবীর সরকার",
    image: "assets/images/1-minte.jpg",
    normalPrice: 300,
    discountedPrice: 250,
    description: "This is a nice book.",
    category: "bangla",
    publication: "Adorsho Publication",
  ),
  Book(
    bookId: "2",
    title: "গ্রে লেডি অব বাগরাম",
    author: "আফিয়া সিদ্দিকী",
    image: "assets/images/Aafia-front.jpg",
    normalPrice: 300,
    discountedPrice: 234,
    description: "This is a nice book.",
    category: "bangla",
    publication: "Adorsho Publication",
  ),
  Book(
    bookId: "3",
    title: "কালকের আন্দোলন, আজকের আন্দোলন",
    author: "অনুপম দেবাশীষ রায়",
    image: "assets/images/ajker-andolon.png",
    normalPrice: 300,
    discountedPrice: 204,
    description: "This is a nice book",
    category: "bangla",
    publication: "Adorsho Publication",
  ),
  Book(
    bookId: "4",
    title: "এখানে আকাশ নীল",
    author: "রবিউল করিম মৃদুল",
    image: "assets/images/Akhane-akash-nil.png",
    normalPrice: 300,
    discountedPrice: 240,
    description: "This is a nice book.",
    category: "bangla",
    publication: "Adorsho Publication",
  ),
  Book(
    bookId: "5",
    title: "একটু গভিরে এসো",
    author: "নবায়ন পারভেজ",
    image: "assets/images/Aktu-gobare-aso.jpg",
    normalPrice: 400,
    discountedPrice: 240,
    description: "This is a nice book.",
    category: "bangla",
    publication: "Adorsho Publication",
  ),
  Book(
    bookId: "6",
    title: "অ্যালগরিদম ডিজাইন",
    author: "অরিন্দম পাল",
    image: "assets/images/Algoridom-Design-1-1.jpg",
    normalPrice: 230,
    discountedPrice: 180,
    description: "This is a nice book.",
    category: "bangla",
    publication: "Adorsho Publication",
  ),
  Book(
    bookId: "7",
    title: "পানকৌড়ির রক্ত",
    author: "আল মাহমুদ",
    image: "assets/images/pankari.jpg",
    normalPrice: 240,
    discountedPrice: 220,
    description: "This is a nice book.",
    category: "English",
    publication: "Profile Publication",
  ),
  Book(
    bookId: "8",
    title: "অ্যাম্বাসেডর",
    author: "আবদুস সালাম জাইফ",
    image: "assets/images/Ambassador-Front.jpg",
    normalPrice: 180,
    discountedPrice: 150,
    description: "This is a nice book",
    category: "English",
    publication: "Profile Publication",
  ),
  Book(
    bookId: "9",
    title: "এটিচিউড ইজ এভরিথিং",
    author: "ত্বাইরান আবির",
    image: "assets/images/Attitude-Is-Everything-Front.jpg",
    normalPrice: 230,
    discountedPrice: 180,
    description: "This is a nice book.",
    category: "English",
    publication: "Profile Publication",
  ),
  Book(
    bookId: "10",
    title: "আয়না",
    author: "আফজাল গুরু",
    image: "assets/images/Ayna-Front.jpg",
    normalPrice: 120,
    discountedPrice: 100,
    description: "This is a nice book.",
    category: "English",
    publication: "Profile Publication",
  ),
  Book(
    bookId: "11",
    title: "আজাদির লড়াই",
    author: "মুহাম্মদ নাফিস নাওয়ার",
    image: "assets/images/Azadi-Front.jpg",
    normalPrice: 230,
    discountedPrice: 190,
    description: "This is a nice book.",
    category: "Social",
    publication: "Somokalin Publication",
  )
];
