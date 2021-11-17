import 'package:auto_size_text/auto_size_text.dart';
import 'package:boiwalaa/model/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:velocity_x/velocity_x.dart';

import 'product_card_vertical.dart';

class Section extends StatelessWidget {
  const Section({
    Key? key,
    required this.section,
  }) : super(key: key);

  final SectionModel section;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.percentHeight * 30,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: context.percentWidth * 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.percentWidth * 3),
              color: Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.percentWidth * 5,
                        vertical: context.percentHeight * 1.5),
                    child: AutoSizeText(
                      section.sectionTitle,
                      style: TextStyle(
                          fontSize: context.percentWidth * 5,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: section.seeAll,
                  child: Container(
                    padding: EdgeInsets.only(right: context.percentWidth * 5),
                    width: context.percentWidth * 18,
                    child: "See all >".text.color(Colors.blue).makeCentered(),
                  ),
                )
              ],
            ),
          ),
          HeightBox(context.percentHeight * 2),
          Expanded(
            child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: context.percentWidth * 5),
                child:

                    // Author Section

                    section.sectionType == SectionType.authorSection
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            addAutomaticKeepAlives: true,
                            itemBuilder: (context, index) {
                              final author =
                                  section.authorSection!.authors[index];
                              return CircleAvatar(
                                radius: context.percentWidth * 10,
                                backgroundColor: Colors.grey[200],
                                child: author.authorImgUrl == ""
                                    ? author.authorName.text
                                        .makeCentered()
                                        .px(5)
                                    : Image(
                                        image:
                                            NetworkImage(author.authorImgUrl),
                                      ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return WidthBox(context.percentWidth * 3);
                            },
                            itemCount: section.authorSection!.authors.length)

                        // Book Section

                        : section.sectionType == SectionType.bookSection
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                addAutomaticKeepAlives: true,
                                itemBuilder: (context, index) {
                                  return productCard(
                                    context: context,
                                    book: section.bookSection!.books[index],
                                    duration: index,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return WidthBox(context.percentWidth * 3);
                                },
                                itemCount: 10)

                            //Category Section

                            : section.sectionType == SectionType.categorySection
                                ? Wrap(
                                    spacing: 5,
                                    children: List.generate(
                                        section
                                            .categorySection!.categories.length,
                                        (index) => Chip(
                                            backgroundColor: Colors.grey[200],
                                            label: section.categorySection!
                                                .categories[index].title.text
                                                .make())),
                                  )

                                // Publication Section

                                : ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    addAutomaticKeepAlives: true,
                                    itemBuilder: (context, index) {
                                      final publication = section
                                          .publicationSection!
                                          .publications[index];
                                      return CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: publication.pubImgUrl == ""
                                            ? publication.pubName
                                                .substring(0, 1)
                                                .text
                                                .makeCentered()
                                            : Image(
                                                image: NetworkImage(
                                                  publication.pubImgUrl,
                                                ),
                                              ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return WidthBox(context.percentWidth * 3);
                                    },
                                    itemCount:
                                        section.authorSection!.authors.length)),
          ),
        ],
      ),
    );
  }
}
