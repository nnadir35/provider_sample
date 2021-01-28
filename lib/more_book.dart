import 'dart:convert';

import 'package:flutter/material.dart';
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
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: 18,
                    itemBuilder: (context, index) {
                      var books = jsonDecode(snapshot.data.toString());
                      return snapshot.hasData
                          ? buildBookImage(context, false, 100,
                              title: books[index]["title"],
                              imagePath: books[index]["imageLink"])
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
