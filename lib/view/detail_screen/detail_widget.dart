import 'package:auto_size_text/auto_size_text.dart';
import 'package:boiwalaa/model/book.dart';
import 'package:boiwalaa/view/global_widget/custom_expansion.dart';
import 'package:boiwalaa/view/global_widget/title_text.dart';
import 'package:boiwalaa/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget detailWidget(BuildContext context, BookModel book) {
  var screenWidth = MediaQuery.of(context).size.width;
  return DraggableScrollableSheet(
    maxChildSize: .9,
    initialChildSize: .53,
    minChildSize: .53,
    builder: (context, scrollController) {
      return Container(
        padding: EdgeInsets.only(
          top: context.percentWidth * 5,
          left: context.percentWidth * 5,
          right: context.percentWidth * 5,
          bottom: 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.05),
            topRight: Radius.circular(screenWidth * 0.05),
          ),
          color: Colors.grey[200],
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 5),
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: context.percentWidth * 70,
                        child: AutoSizeText(
                          book.bookName,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          "${book.normalPrice}"
                              .text
                              .xl3
                              .red500
                              .lineThrough
                              .bold
                              .make(),
                          const SizedBox(
                            width: 10,
                          ),
                          "${book.discountedPercent}".text.black.xl3.bold.make(),
                          "(Save ${(100 - ((book.discountedPercent * 100) / book.normalPrice)).toStringAsFixed(0)}%)"
                              .text
                              .make()
                        ],
                      ),
                      SizedBox(
                        height: screenWidth * 0.03,
                      ),
                      Text(
                        "In Stock",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                  Icon(
                    Icons.favorite,
                    size: screenWidth * 0.1,
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              _category(context, book),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),

              TabBar(indicatorColor: Colors.black, tabs: [
                Tab(
                  child: "Description".text.black.make(),
                ),
                Tab(
                  child: "Details".text.black.make(),
                ),
                Tab(
                  child: "Reviews".text.black.make(),
                ),
              ]),

              Container(
                padding: EdgeInsets.only(top: context.percentWidth * 5),
                height: context.percentHeight * 35,
                width: double.infinity,
                child: TabBarView(children: [
                  book.description.text.make(),
                  book.description.text.make(),
                  book.description.text.make(),
                ]),
              ),
              // _description(context),
              // Theme(
              //   data: ThemeData(
              //       colorScheme: ColorScheme.fromSwatch()
              //           .copyWith(secondary: Colors.black)),
              //   child: customExpansion(
              //     context: context,
              //     expanded: false,
              //     expansionTitle: "Summery",
              //     widgets: [
              //       Padding(
              //         padding: EdgeInsets.only(
              //           left: screenWidth * 0.04,
              //           right: screenWidth * 0.04,
              //           top: 0,
              //           bottom: screenWidth * 0.05,
              //         ),
              //         child: Text(
              //           book.description,
              //           // textAlign: TextAlign.start,
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 10,
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontSize: screenWidth * 0.05,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: screenWidth * 0.03),
              // Theme(
              //   data: ThemeData(
              //       colorScheme: ColorScheme.fromSwatch()
              //           .copyWith(secondary: Colors.black)),
              //   child: customExpansion(
              //       context: context,
              //       expanded: false,
              //       expansionTitle: "Specification",
              //       widgets: [
              //         Padding(
              //           padding: EdgeInsets.only(
              //             left: screenWidth * 0.04,
              //             right: screenWidth * 0.04,
              //             top: 0,
              //             bottom: screenWidth * 0.05,
              //           ),
              //           child: Container(
              //             child: Column(
              //               children: [
              //                 Row(
              //                   children: [
              //                     TitleText(
              //                       text: "Author:  ",
              //                       fontSize: screenWidth * 0.05,
              //                       color: Colors.black,
              //                     ),
              //                     Text(
              //                       book.author,
              //                       style: TextStyle(
              //                         fontSize: screenWidth * 0.04,
              //                         color: AppColors.green,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 SizedBox(height: screenWidth * 0.03),
              //                 Row(
              //                   children: [
              //                     TitleText(
              //                       text: "Cover Type:  ",
              //                       fontSize: screenWidth * 0.05,
              //                       color: Colors.black,
              //                     ),
              //                     Text(
              //                       book.coverType.toString(),
              //                       style: TextStyle(
              //                         fontSize: screenWidth * 0.04,
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 SizedBox(height: screenWidth * 0.03),
              //                 Row(
              //                   children: [
              //                     TitleText(
              //                       text: "Language:  ",
              //                       fontSize: screenWidth * 0.05,
              //                       color: Colors.black,
              //                     ),
              //                     Text(
              //                       book.language.toString(),
              //                       style: TextStyle(
              //                         fontSize: screenWidth * 0.04,
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 SizedBox(height: screenWidth * 0.03),
              //                 Row(
              //                   children: [
              //                     TitleText(
              //                       text: "Publisher:  ",
              //                       fontSize: screenWidth * 0.05,
              //                       color: Colors.black,
              //                     ),
              //                     Text(
              //                       book.publication,
              //                       style: TextStyle(
              //                         fontSize: screenWidth * 0.04,
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 SizedBox(height: screenWidth * 0.03),
              //                 Row(
              //                   children: [
              //                     TitleText(
              //                       text: "Edition:  ",
              //                       fontSize: screenWidth * 0.05,
              //                       color: Colors.black,
              //                     ),
              //                     Text(
              //                       book.edition,
              //                       style: TextStyle(
              //                         fontSize: screenWidth * 0.04,
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 SizedBox(height: screenWidth * 0.03),
              //                 Row(
              //                   children: [
              //                     TitleText(
              //                       text: "ISBN/ISSN:  ",
              //                       fontSize: screenWidth * 0.05,
              //                       color: Colors.black,
              //                     ),
              //                     Text(
              //                       book.isbn,
              //                       style: TextStyle(
              //                         fontSize: screenWidth * 0.04,
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ]),
              // ),
              // SizedBox(
              //   height: screenWidth * 0.2,
              // )
            ],
          ),
        ),
      );
    },
  );
}

Widget _category(BuildContext context, BookModel book) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const TitleText(
        text: "Category",
        fontSize: 20,
        color: Colors.black,
      ),
      const Spacer(),
      SizedBox(
        width: context.percentWidth * 65,
        child: Wrap(
          alignment: WrapAlignment.end,
          spacing: 5,
          children: List.generate(
              book.categories.length,
              (index) => Chip(
                  backgroundColor: Colors.white,
                  label: book.categories[index].title.text.make())),
        ),
      ),
      // Text(
      //   book.categories,
      //   style: const TextStyle(
      //     color: AppColors.green,
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //   ),
      // )
    ],
  );
}
