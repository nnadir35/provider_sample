import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:provider_sample/book_data.dart';

class HomePageProvider extends ChangeNotifier {
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

  queryByLanguage(List<Book> bookList) {
    booksForUser.clear();
    bookList.forEach((book) {
      if (book.language == language) {
        booksForUser.add(book);
      }
    });
    print(booksForUser.length.toString());
    notifyListeners();
  }

  // randomBookGenerate() async {
  //   List<Book> allbooks = await allBooks();
  //   randomBook = allbooks[Random().nextInt(13)];
  //   return randomBook;
  // }
}
