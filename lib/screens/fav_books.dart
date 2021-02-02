import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:provider_sample/provider/book_provider.dart';
import 'package:provider_sample/provider/fav_books_provider.dart';
import 'package:provider_sample/widgets.dart';

class FavoriteBooks extends StatefulWidget {
  @override
  _FavoriteBooksState createState() => _FavoriteBooksState();
}

class _FavoriteBooksState extends State<FavoriteBooks> {
  @override
  Widget build(BuildContext context) {
    var bookProvider = Provider.of<BookProvider>(context);
    var favBookProvider = Provider.of<FavoriteBooksProvider>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    buildSizedBox(24),
                    Text(
                      "OKUMA LİSTEM",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Flexible(
              flex: 12,
              child: ListView.builder(
                itemCount: favBookProvider.favBookList.length,
                itemBuilder: (BuildContext context, int index) {
                  return newMethod(context, favBookProvider, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container newMethod(
      BuildContext context, FavoriteBooksProvider provider, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.3, color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              child: Image(
                image: AssetImage(provider.favBookList[index].imageLink),
              ),
            ),
          ),
          Column(
            children: [
              Text(provider.favBookList[index].author),
              Text(provider.favBookList[index].title),
            ],
          ),
          IconButton(
            onPressed: () => provider.deleteBook(provider.favBookList[index]),
            icon: Icon(
              Icons.delete_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
