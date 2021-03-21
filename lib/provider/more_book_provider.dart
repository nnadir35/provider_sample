import 'package:flutter/foundation.dart';
import 'package:provider_sample/assets/model/book_data.dart';

class MoreBookProvider extends ChangeNotifier {
  String type;

  List<Book> queryList = <Book>[];

  queryBook(List<Book> allBooks) {
    queryList.clear();
    var x = type.toLowerCase();
    allBooks.forEach((book) {
      if (book.title.toLowerCase().contains(x) == true ||
          book.author.toLowerCase().contains(x) == true) {
        queryList.add(book);
      }
    });
    //type = "";
    print("type: " + type.toString());
    notifyListeners();
  }
}
