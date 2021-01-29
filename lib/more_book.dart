import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider_sample/book_detail.dart';
import 'package:provider_sample/widgets.dart';

class MoreBook extends StatefulWidget {
  @override
  _MoreBookState createState() => _MoreBookState();
}

class _MoreBookState extends State<MoreBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(flex: 1, child: buildSearchBar()),
          Flexible(
            flex: 6,
            child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString("lib/assets/json/books.json"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    itemCount: 18,
                    itemBuilder: (BuildContext context, int index) {
                      var books = jsonDecode(snapshot.data.toString());
                      return snapshot.hasData
                          ? buildLine(context, books, index)
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Container buildLine(BuildContext context, books, int index) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              child: Image(
                image: AssetImage(books[index]["imageLink"]),
              ),
            ),
          ),
          aboutBook(books, index),
          navigateBookDetail(context, books, index),
        ],
      ),
    );
  }

  IconButton navigateBookDetail(BuildContext context, books, int index) {
    return IconButton(
      icon: Icon(
        Icons.arrow_forward_ios,
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetail(
            title: books[index]["title"],
            author: books[index]["author"],
            page: "789",
            bookImage: books[index]["imageLink"],
          ),
        ),
      ),
    );
  }

  Column aboutBook(books, int index) {
    return Column(
      children: [
        Text(books[index]["title"]),
        Text(books[index]["author"]),
      ],
    );
  }

  Widget buildSearchBar() {
    return Container(
      margin: EdgeInsets.only(top: 50, right: 10, left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
          hintText: 'Kitap veya yazar adı girin',
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 5, top: 12),
        ),
      ),
    );
  }
}
