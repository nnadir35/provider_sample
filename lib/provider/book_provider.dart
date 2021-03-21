import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider_sample/assets/model/book_data.dart';




class BookProvider extends ChangeNotifier {
  List<Book> bookList = <Book>[];
  Book selectedBook;
  Future<List<Book>> allBooks() async {
    List<Book> x = <Book>[];
    var data = jsonDecode(
        await rootBundle.loadString("lib/assets/json/newbooks.json"));
    data.forEach((element) => x.add(Book.fromJson(element)));
    bookList = x.toSet().toList();
    bookList.shuffle();
    return bookList;
  }

  List<String> languages = ["İngilizce", "Fransızca", "Almanca"];
  List<Book> booksForUser = <Book>[];
  String selectedLanguage;

  Book randomBook;

  Map<String, String> languageMap = {
    "İngilizce": "English",
    "Fransızca": "French",
    "Almanca": "German",
    "Rusça": "Russian",
    "İtalyanca": "Italian",
    "İspanyolca": "Spanish",
    "Arapça": "Arabic",
    "Danca": "Danish"
  };

  dropdownButtonValueChange(String value) {
    selectedLanguage = value;
    notifyListeners();
  }

  Future<List<Book>> queryByLanguage() async {
    booksForUser.clear();
    await allBooks().then((booklist) {
      bookList.forEach((book) {
        if (book.language == selectedLanguage) {
          booksForUser.add(book);
        }
      });
    });
    return booksForUser;
  }

  Future<Book> randomBookGenerate() async {
    await allBooks().then((books) {
      randomBook = books[Random().nextInt(100)];
    });
    return randomBook;
  }
}
