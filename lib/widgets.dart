import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_sample/book_detail.dart';

String dummy =
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

Container buildBookHorizontalListView1(BuildContext context) {
  return Container(
    height: 200,
    child: FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString("lib/assets/json/books.json"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var books = jsonDecode(snapshot.data.toString());
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return snapshot.hasData == false
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: buildBookImage(
                      context,
                      false,
                      125,
                      title: books[index]["title"],
                      author: books[index]["author"],
                      page: books[index]["page"],
                      imagePath: books[index]["imageLink"],
                    ),
                  );
          },
        );
      },
    ),
  );
}

Container buildBookImage(BuildContext context, bool big, double height,
    {String title, String author, String page, String imagePath}) {
  return Container(
    height: 515,
    width: big == true ? MediaQuery.of(context).size.width : 100,
    child: Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetail(
                title: title,
                author: author,
                page: page,
                bookImage: imagePath,
              ),
            ),
          ),
          child: Container(
            height: height,
            child: Image(
              image: AssetImage(imagePath),
            ),
          ),
        ),
        buildText(
          title == null ? "" : title,
          13,
          Colors.black,
        ),
      ],
    ),
  );
}

// Container buildBookHorizontalListView(String imagePathForFun, {String data}) {
//   return Container(
//     height: 200,
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: 5,
//       itemBuilder: (BuildContext context, int index) {
//         return buildBookImage(imagePathForFun, context, false, data: data);
//       },
//     ),
//   );
// }

Container buildText(String text, double fontSize, Color color) {
  return Container(
    alignment: Alignment.topLeft,
    child: Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
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
