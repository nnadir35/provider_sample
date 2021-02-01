import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/book_provider.dart';
import 'package:provider_sample/screens/book_detail.dart';
import 'package:provider_sample/screens/fav_books.dart';
import 'package:provider_sample/screens/homepage.dart';
import 'package:provider_sample/screens/more_book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BookProvider bookListService = BookProvider();
  final BookProvider bookService = BookProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => bookListService.allBooks(),
        ),
        FutureProvider(
          create: (context) => bookService.randomBookGenerate(),
        ),
        FutureProvider(
          create: (context) => bookService.queryByAuthor(),
        ),
        ChangeNotifierProvider(
          create: (
            context,
          ) =>
              bookService,
        )
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
