import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/book_data.dart';
import 'package:provider_sample/provider/book_provider.dart';

class MoreBook extends StatefulWidget {
  @override
  _MoreBookState createState() => _MoreBookState();
}

class _MoreBookState extends State<MoreBook> {
  BookProvider provider;
  List<Book> listBookService;
  @override
  Widget build(BuildContext context) {
    listBookService = Provider.of<List<Book>>(context);
    provider = Provider.of<BookProvider>(context);
    return Scaffold(body: Column(children: [listView(context)]));
  }

  Container listView(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: provider.bookList.length,
            itemBuilder: (BuildContext context, int index) {
              return listBookService == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : rowStyle(index, context);
            }));
  }

  Container rowStyle(int index, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.grey),
      ),
      child: GestureDetector(
        onTap: () {
          provider.selectedBook = listBookService[index];
          Navigator.pushNamed(context, "/book_detail");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image(context, index),
            bookInfo(index),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }

  Column bookInfo(int index) {
    return Column(
      children: [
        Text(listBookService[index].title),
        Text(listBookService[index].author),
      ],
    );
  }

  Padding image(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: Image(
          image: AssetImage(listBookService[index].imageLink),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      margin: EdgeInsets.only(top: 50, right: 10, left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
          hintText: 'Kitap veya yazar adı girin',
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 5, top: 12),
        ),
      ),
    );
  }
}
