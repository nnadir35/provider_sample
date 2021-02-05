import 'package:flutter/foundation.dart';
import 'package:provider_sample/book_data.dart';

class MoreBookProvider extends ChangeNotifier {
  String type;

  List<Book> queryList = <Book>[];

  queryBook(List<Book> allBooks) {
    queryList.clear();
    var x = type.toLowerCase();
    allBooks.forEach((book) {
      if (book.title.toLowerCase().contains(x) == true ||
          book.author.toLowerCase().contains(x) == true) {
        print("oluru var ");
        queryList.add(book);
      }
    });
    print("queryList.length: " + queryList.length.toString());
    notifyListeners();
  }
}
