import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customExpansion(
    {BuildContext? context,
    String? expansionTitle,
    List<Widget>? widgets,
    bool? expanded,
    String? expansionSubtitle}) {
  var screenWidth = MediaQuery.of(context!).size.width;
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03)),
    child: Theme(
      data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber)),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.grey[200],
        backgroundColor: Colors.grey[200],
        initiallyExpanded: expanded!,
        title: Text(
          expansionTitle!,
          style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        children: widgets!,
      ),
    ),
  );
}

Widget boiwalaaExpansion(
    {BuildContext? context,
    String? expansionTitle,
    List<Widget>? widgets,
    bool? expanded,
    String? expansionSubtitle}) {
  var screenWidth = MediaQuery.of(context!).size.width;
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03)),
    child: Theme(
      data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber)),
      child: ExpansionTile(
        backgroundColor: Colors.grey[200],
        initiallyExpanded: expanded!,
        subtitle: Text(
          expansionSubtitle!,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            color: Colors.black,
          ),
        ),
        title: Text(
          expansionTitle!,
          style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        children: widgets!,
      ),
    ),
  );
}
