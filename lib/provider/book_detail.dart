import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider_sample/book_data.dart';

class BookDetailProvider extends ChangeNotifier {
  List<Book> authorsBooks = <Book>[];

  queryByAuthor(List<Book> bookList, Book selectedBook) {
    authorsBooks.clear();
    bookList.forEach((book) {
      if (book.author == selectedBook.author &&
          book.title != selectedBook.title) {
        authorsBooks.add(book);
      }
    });
    notifyListeners();
  }
}
