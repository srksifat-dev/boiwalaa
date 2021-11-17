class AuthorModel {
  final String authorName;
  final String authorImgUrl;
  final String soldBooks;
  AuthorModel({
    required this.authorName,
    this.authorImgUrl = "",
    this.soldBooks = "0",
  });
}
