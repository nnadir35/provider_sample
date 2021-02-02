import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/provider/book_detail.dart';
import 'package:provider_sample/provider/book_provider.dart';
import 'package:provider_sample/provider/fav_books_provider.dart';
import 'package:provider_sample/screens/book_detail.dart';
import 'package:provider_sample/screens/fav_books.dart';
import 'package:provider_sample/screens/homepage.dart';
import 'package:provider_sample/screens/more_book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BookProvider bookProvider = BookProvider();
  final BookDetailProvider bookDetailProvider = BookDetailProvider();
  final FavoriteBooksProvider favBooksProvider = FavoriteBooksProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => bookProvider.allBooks(),
        ),
        FutureProvider(
          create: (context) => bookProvider.randomBookGenerate(),
        ),
        ChangeNotifierProvider(
          create: (
            context,
          ) =>
              bookProvider,
        ),
        ChangeNotifierProvider(
          create: (
            context,
          ) =>
              favBooksProvider,
        ),
        ChangeNotifierProvider(
          create: (
            context,
          ) =>
              bookDetailProvider,
        ),
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => MyHomePage(),
          "/book_detail": (context) => BookDetail(),
          "/more_book": (context) => MoreBook(),
          "/fav_books": (context) => FavoriteBooks(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
