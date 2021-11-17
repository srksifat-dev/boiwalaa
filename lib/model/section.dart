import 'package:boiwalaa/view/global_widget/section.dart';
import 'package:flutter/cupertino.dart';

import 'package:boiwalaa/model/author.dart';
import 'package:boiwalaa/model/author_section.dart';
import 'package:boiwalaa/model/book.dart';
import 'package:boiwalaa/model/book_section.dart';
import 'package:boiwalaa/model/category.dart';
import 'package:boiwalaa/model/category_section.dart';
import 'package:boiwalaa/model/publication_section.dart';

enum SectionType {
  bookSection,
  authorSection,
  categorySection,
  publicationSection,
}

class SectionModel {
  final SectionType sectionType;
  final String sectionTitle;
  final VoidCallback seeAll;
  final int index;
  final AuthorSection? authorSection;
  final BookSection? bookSection;
  final CategorySection? categorySection;
  final PublicationSection? publicationSection;
  SectionModel({
    required this.sectionType,
    required this.sectionTitle,
    required this.seeAll,
    required this.index,
    this.authorSection,
    this.bookSection,
    this.categorySection,
    this.publicationSection,
  });
}

final sections = [
  Section(
    section: SectionModel(
      sectionType: SectionType.bookSection,
      sectionTitle: "Today's Offer",
      seeAll: () {},
      index: 1,
      bookSection: BookSection(books: demoBooks),
    ),
  ),
  Section(
    section: SectionModel(
      sectionTitle: "ক্যাটাগরি সমূহ",
      seeAll: () {},
      sectionType: SectionType.categorySection,
      index: 2,
      categorySection: CategorySection(
        categories: [
          CategoryModel(title: "Bangla"),
          CategoryModel(title: "English"),
          CategoryModel(title: "Computer"),
          CategoryModel(title: "Programming"),
          CategoryModel(title: "History"),
          CategoryModel(title: "Drama"),
          CategoryModel(title: "Romantic"),
          CategoryModel(title: "Motivation"),
          CategoryModel(title: "Social"),
        ],
      ),
    ),
  ),
  Section(
    section: SectionModel(
      sectionTitle: "Sold books: Live",
      seeAll: () {},
      sectionType: SectionType.bookSection,
      index: 3,
      bookSection: BookSection(books: demoBooks),
    ),
  ),
  Section(
    section: SectionModel(
      sectionTitle: "আপনার পছন্দের বইগুলো",
      seeAll: () {},
      sectionType: SectionType.bookSection,
      index: 4,
      bookSection: BookSection(books: demoBooks),
    ),
  ),
  Section(
    section: SectionModel(
      sectionTitle: "আপনি যেই ক্যাটাগরির বই পড়তে ভালোবাসেন",
      seeAll: () {},
      sectionType: SectionType.categorySection,
      index: 5,
      categorySection: CategorySection(
        categories: [
          CategoryModel(title: "Bangla"),
          CategoryModel(title: "English"),
          CategoryModel(title: "Computer"),
          CategoryModel(title: "Programming"),
          CategoryModel(title: "History"),
          CategoryModel(title: "Drama"),
          CategoryModel(title: "Romantic"),
          CategoryModel(title: "Motivation"),
          CategoryModel(title: "Social"),
        ],
      ),
    ),
  ),
  Section(
    section: SectionModel(
        sectionTitle: "এই সপ্তাহের বেস্ট সেলার বইগুলো",
        seeAll: () {},
        sectionType: SectionType.bookSection,
        index: 6,
        bookSection: BookSection(books: demoBooks)),
  ),
  Section(
    section: SectionModel(
      sectionTitle: "Weekly top authors",
      seeAll: () {},
      sectionType: SectionType.authorSection,
      index: 7,
      authorSection: AuthorSection(
        authors: [
          AuthorModel(authorName: "হূমায়ূন আহমেদ"),
          AuthorModel(authorName: "হূমায়ূন আহমেদ"),
          AuthorModel(authorName: "হূমায়ূন আহমেদ"),
          AuthorModel(authorName: "হূমায়ূন আহমেদ"),
          AuthorModel(authorName: "হূমায়ূন আহমেদ"),
        ],
      ),
    ),
  ),
];
