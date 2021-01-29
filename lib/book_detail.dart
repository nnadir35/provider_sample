import 'package:flutter/material.dart';
import 'package:provider_sample/widgets.dart';

class BookDetail extends StatefulWidget {
  String title;
  String author;
  String page;
  String bookImage;
  BookDetail({Key key, this.author, this.title, this.page, this.bookImage})
      : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildSelectedBookImage(),
          selectedBookInfo(),
          buildSizedBox(12),
          buildText("Yazara Ait Diger Kitaplar", 24, Colors.black),
          buildSizedBox(12),
          buildBookHorizontalListView1(context),
        ],
      ),
    );
  }

  Expanded selectedBookInfo() {
    return Expanded(
      flex: 3,
      child: Container(
        child: Column(
          children: [
            buildBookProperty(),
            buildInsideBook(),
          ],
        ),
      ),
    );
  }

  Expanded buildInsideBook() {
    return Expanded(
      flex: 2,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: buildText(dummy, 24, Colors.grey),
        ),
      ),
    );
  }

  Container buildBookProperty() {
    return Container(
      child: Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.author,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  //Text(widget.page),
                ],
              ),
            ),
            IconButton(
                icon: status == false
                    ? Icon(
                        Icons.bookmark_border,
                        size: 36,
                      )
                    : Icon(
                        Icons.bookmark,
                        size: 36,
                        color: Colors.yellow,
                      ),
                onPressed: () {
                  setState(() {
                    status = !status;
                  });
                })
          ],
        ),
      ),
    );
  }

  Expanded buildSelectedBookImage() {
    return Expanded(
      flex: 2,
      child: buildSplash(context: context, imagePath: widget.bookImage),
    );
  }
}
