import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider_sample/book_data.dart';

class BookProvider extends ChangeNotifier {
  List<Book> bookList = <Book>[];

  Future<List<Book>> allBooks() async {
    List<Book> x = <Book>[];
    var data =
        jsonDecode(await rootBundle.loadString("lib/assets/json/books.json"));
    data.forEach((element) => x.add(Book.fromJson(element)));
    bookList = x.toSet().toList();
    return bookList;
  }

  List<Book> authorsBooks = <Book>[];

  queryByAuthor() {
    authorsBooks.clear();
    bookList.forEach((book) {
      if (book.author == selectedBook.author &&
          book.title != selectedBook.title) {
        authorsBooks.add(book);
      }
    });
    return authorsBooks;
  }

  bool listContain;
  List<Book> favBookList = <Book>[];

  favBookQuery() {
    int x = 0;
    favBookList.forEach((book) {
      book.title == selectedBook.title ? x++ : null;
    });
    x == 1 ? listContain = true : listContain = false;
    print(listContain.toString());
    //notifyListeners();
  }

  Book selectedBook;

  addBookToFav(Book selectedBook) {
    listContain == false ? favBookList.add(selectedBook) : null;
    notifyListeners();
  }

  deleteBook(Book selectedBook) {
    favBookList.remove(selectedBook);
    notifyListeners();
  }

  Book randomBook;

  randomBookGenerate() async {
    List<Book> allbooks = await allBooks();
    randomBook = allbooks[Random().nextInt(13)];
    return randomBook;
  }
}
