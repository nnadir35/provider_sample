import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/book_data.dart';
import 'package:provider_sample/book_provider.dart';
import 'package:provider_sample/widgets.dart';

class BookDetail extends StatefulWidget {
  BookDetail({
    Key key,
  }) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  bool status = false;
  BookProvider provider;
  List<Book> listBookService;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<BookProvider>(context);
    listBookService = Provider.of<List<Book>>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.2,
            child: Consumer<BookProvider>(
              builder: (context, value, child) {
                return newSplash(context, value.selectedBook.imageLink);
              },
            ),
          ),
          selectedBookInfo(),
          buildSizedBox(12),
          buildText("Yazara Ait Diger Kitaplar", 22, Colors.black),
          buildSizedBox(12),
          authorOtherBooks(context),
        ],
      ),
    );
  }

  Container authorOtherBooks(BuildContext context) {
    provider.queryByAuthor();
    return Container(
      height: MediaQuery.of(context).size.height / 3.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.authorsBooks.length,
        itemBuilder: (BuildContext context, int index) {
          return listBookService == null
              ? Center(
                  child: Text("boş"),
                )
              : GestureDetector(
                  onTap: () {
                    provider.selectedBook = provider.authorsBooks[index];
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/book_detail", ModalRoute.withName("/"));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: buildBookImage(
                      context,
                      false,
                      125,
                      title: provider.authorsBooks[index].title,
                      imagePath: provider.authorsBooks[index].imageLink,
                    ),
                  ),
                );
        },
      ),
    );
  }

  Expanded selectedBookInfo() {
    return Expanded(
      flex: 4,
      child: Container(
        child: Column(
          children: [
            buildBookProperty(),
            buildInsideBook(),
          ],
        ),
      ),
    );
  }

  Expanded buildInsideBook() {
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: buildText(dummy, 18, Colors.grey),
        ),
      ),
    );
  }

  Container buildBookProperty() {
    return Container(
      child: Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.selectedBook.title,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    provider.selectedBook.author,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),
            addFavIcon()
          ],
        ),
      ),
    );
  }

  IconButton addFavIcon() {
    provider.favBookQuery();
    return IconButton(
      icon: provider.listContain == false
          ? Icon(
              Icons.bookmark_border,
              size: 36,
            )
          : Icon(
              Icons.bookmark,
              size: 36,
              color: Colors.yellow,
            ),
      onPressed: () {
        provider.addBookToFav(provider.selectedBook);
      },
    );
  }

  Expanded buildSelectedBookImage(String imagePath) {
    return Expanded(
      flex: 2,
      child: buildSplash(context: context, imagePath: imagePath),
    );
  }
}
