import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/book_data.dart';
import 'package:provider_sample/provider/book_detail_provider.dart';
import 'package:provider_sample/provider/book_provider.dart';
import 'package:provider_sample/provider/fav_books_provider.dart';
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
  FavoriteBooksProvider favoriteBooksProvider;
  BookDetailProvider bookDetailProvider;

  @override
  Widget build(BuildContext context) {
    bookDetailProvider = Provider.of<BookDetailProvider>(context);
    provider = Provider.of<BookProvider>(context);
    listBookService = Provider.of<List<Book>>(context);
    favoriteBooksProvider = Provider.of<FavoriteBooksProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          bookImage(context),
          selectedBookInfo(),
          buildText(
              "Yazara Ait Diger Kitaplar", 22, Colors.black, FontWeight.w900),
          authorOtherBooks(context),
        ],
      ),
    );
  }

  Container bookImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.3,
      child: Consumer<BookProvider>(
        builder: (context, value, child) {
          return newSplash(context, value.selectedBook.imageLink);
        },
      ),
    );
  }

  Expanded selectedBookInfo() {
    return Expanded(
      flex: 4,
      child: Column(
        children: [
          buildBookProperty(),
          buildInsideBook(),
        ],
      ),
    );
  }

  Container authorOtherBooks(BuildContext context) {
    bookDetailProvider.queryByAuthor(provider.bookList, provider.selectedBook);
    return Container(
      height: MediaQuery.of(context).size.height / 3.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bookDetailProvider.authorsBooks.length,
        itemBuilder: (BuildContext context, int index) {
          return listBookService == null
              ? Center(
                  child: Text("boş"),
                )
              : GestureDetector(
                  onTap: () {
                    provider.selectedBook =
                        bookDetailProvider.authorsBooks[index];
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/book_detail", ModalRoute.withName("/"));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: buildBookImage(
                      context,
                      false,
                      125,
                      title: bookDetailProvider.authorsBooks[index].title,
                      imagePath:
                          bookDetailProvider.authorsBooks[index].imageLink,
                    ),
                  ),
                );
        },
      ),
    );
  }

  Expanded buildInsideBook() {
    return Expanded(
      flex: 2,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: buildText(dummy, 18, Colors.grey, FontWeight.normal),
        ),
      ),
    );
  }

  Widget buildBookProperty() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                buildText(provider.selectedBook.title, 22, Colors.black,
                    FontWeight.w600),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildText(provider.selectedBook.author, 18, Colors.black,
                        FontWeight.w300),
                    Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 12,
                    ),
                    buildText(provider.selectedBook.year, 18, Colors.black,
                        FontWeight.w300),
                  ],
                ),
              ],
            ),
          ),
          addFavIcon()
        ],
      ),
    );
  }

  IconButton addFavIcon() {
    favoriteBooksProvider.favBookQuery(provider.selectedBook);
    return IconButton(
      icon: favoriteBooksProvider.listContain == false
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
        favoriteBooksProvider.addBookToFav(provider.selectedBook);
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
