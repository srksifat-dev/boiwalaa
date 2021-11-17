class PublicationModel {
  final String pubName;
  final String pubImgUrl;
  final String soldBooks;
  PublicationModel({
    required this.pubName,
    this.pubImgUrl = "",
    this.soldBooks = "0",
  });
}
