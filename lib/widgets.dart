import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_sample/screens/book_detail.dart';

String dummy =
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

Container buildBookImage(BuildContext context, bool big, double height,
    {String title, String imagePath}) {
  return Container(
    height: 515,
    width: big == true ? MediaQuery.of(context).size.width : 100,
    child: Column(
      children: [
        buildImage(context, imagePath),
        buildText(title, 13, Colors.black, FontWeight.normal),
      ],
    ),
  );
}

Widget buildImage(BuildContext context, String imagePath) {
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image(
        height: 165,
        image: AssetImage(imagePath),
      ),
    ),
  );
}

GestureDetector buildSplash(
    {BuildContext context,
    String title,
    String author,
    String page,
    String imagePath}) {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetail(),
      ),
    ),
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: Image(
        image: AssetImage(imagePath),
      ),
    ),
  );
}

Widget newSplash(BuildContext context, String imagePath) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Image(
      //fit: BoxFit.fitHeight,
      image: AssetImage(imagePath),
    ),
  );
}

Container buildText(
    String text, double fontSize, Color color, FontWeight fontWeight) {
  return Container(
    alignment: Alignment.topLeft,
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}

BoxDecoration buildBookDecoration(Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(24),
  );
}

SizedBox buildSizedBox(double height) {
  return SizedBox(
    height: height,
  );
}
