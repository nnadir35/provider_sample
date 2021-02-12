import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/book_data.dart';
import 'package:provider_sample/provider/book_provider.dart';
import 'package:provider_sample/provider/more_book_provider.dart';

class MoreBook extends StatefulWidget {
  @override
  _MoreBookState createState() => _MoreBookState();
}

class _MoreBookState extends State<MoreBook> {
  BookProvider provider;
  List<Book> listBookService;
  MoreBookProvider moreBookProvider;

  TextEditingController searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    listBookService = Provider.of<List<Book>>(context);
    provider = Provider.of<BookProvider>(context);
    moreBookProvider = Provider.of<MoreBookProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          buildSearchBar(),
          listView(context),
        ],
      ),
    );
  }

  Expanded listView(BuildContext context) {
    print(searchBarController.text);
    return Expanded(
      flex: 6,
      child: Container(
          child: ListView.builder(
              itemCount: moreBookProvider.queryList.length == 0 ||
                      searchBarController.text == ""
                  ? provider.bookList.length
                  : moreBookProvider.queryList.length,
              itemBuilder: (BuildContext context, int index) {
                return provider.bookList == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : rowStyle(index, context);
              })),
    );
  }

  Container rowStyle(int index, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.grey),
      ),
      child: GestureDetector(
        onTap: () {
          moreBookProvider.queryList.length == 0 ||
                  searchBarController.text == ""
              ? provider.selectedBook = provider.bookList[index]
              : provider.selectedBook = moreBookProvider.queryList[index];
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
        moreBookProvider.queryList.length == 0 || searchBarController.text == ""
            ? Text(provider.bookList[index].title)
            : Text(moreBookProvider.queryList[index].title),
        moreBookProvider.queryList.length == 0 || searchBarController.text == ""
            ? Text(provider.bookList[index].author)
            : Text(moreBookProvider.queryList[index].author),
      ],
    );
  }

  Padding image(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: Image(
          image: moreBookProvider.queryList.length == 0 ||
                  searchBarController.text == ""
              ? AssetImage(provider.bookList[index].imageLink)
              : AssetImage(moreBookProvider.queryList[index].imageLink),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(top: 50, right: 10, left: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: searchBarController,
          onChanged: (value) {
            moreBookProvider.type = searchBarController.text;
            moreBookProvider.queryBook(provider.bookList);
          },
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
            hintText: 'Kitap veya yazar adı girin',
            suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 5, top: 12),
          ),
        ),
      ),
    );
  }
}
