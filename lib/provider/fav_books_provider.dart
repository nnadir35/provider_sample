import 'package:flutter/foundation.dart';
import 'package:provider_sample/assets/model/book_data.dart';

class FavoriteBooksProvider extends ChangeNotifier {
  bool listContain = false;
  List<Book> favBookList = <Book>[];

  favBookQuery(Book selectedBook) {
    int x = 0;
    favBookList.forEach((book) {
      if (book.title == selectedBook.title) x++;
    });
    x == 1 ? listContain = true : listContain = false;
    print(selectedBook.title + "status: " + listContain.toString());
    notifyListeners();
  }

  addBookToFav(Book selectedBook) {
    if (listContain == false) favBookList.add(selectedBook);
    notifyListeners();
  }

  deleteBook(Book selectedBook) {
    favBookList.remove(selectedBook);
    notifyListeners();
  }
}
