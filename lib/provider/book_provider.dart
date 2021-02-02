import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider_sample/book_data.dart';

class BookProvider extends ChangeNotifier {
  List<Book> bookList = <Book>[];
  Book selectedBook;
  Future<List<Book>> allBooks() async {
    List<Book> x = <Book>[];
    var data =
        jsonDecode(await rootBundle.loadString("lib/assets/json/books.json"));
    data.forEach((element) => x.add(Book.fromJson(element)));
    bookList = x.toSet().toList();
    bookList.shuffle();
    return bookList;
  }

  List<String> languages = ["İngilizce", "Fransızca", "Almanca"];
  List<Book> booksForUser = <Book>[];
  String language;

  Book randomBook;

  Map<String, String> translateLanguage = {
    "İngilizce": "English",
    "Fransızca": "French",
    "Almanca": "German",
    "Rusça": "Russian"
  };

  dropdownButtonValueChange(String value) {
    language = value;
    notifyListeners();
  }

  queryByLanguage() {
    booksForUser.clear();
    bookList.forEach((book) {
      if (book.language == language) {
        booksForUser.add(book);
      }
    });
    print(booksForUser.length.toString());
    notifyListeners();
  }

  randomBookGenerate() async {
    List<Book> allbooks = await allBooks();
    randomBook = allbooks[Random().nextInt(13)];
    return randomBook;
  }
}
