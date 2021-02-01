import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/book_data.dart';
import 'package:provider_sample/book_provider.dart';
import 'package:provider_sample/screens/book_detail.dart';
import 'package:provider_sample/screens/more_book.dart';
import 'package:provider_sample/widgets.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Book> listBookService;
  BookProvider books;
  Book randomBook;
  @override
  Widget build(BuildContext context) {
    listBookService = Provider.of<List<Book>>(context);
    books = Provider.of<BookProvider>(context);
    randomBook = Provider.of<BookProvider>(context).randomBook;

    return Scaffold(
      body: Column(
        children: [
          buildBody(),
        ],
      ),
    );
  }

  Widget buildBottomBar() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildIconAddFav(),
          buildIconUserPrefs(),
        ],
      ),
    );
  }

  IconButton buildIconUserPrefs() {
    return IconButton(
        icon: Icon(
          Icons.person_outline,
          size: 40,
          color: Colors.grey,
        ),
        onPressed: null);
  }

  IconButton buildIconAddFav() {
    return IconButton(
        icon: Icon(
          Icons.star,
          size: 40,
          color: Colors.yellow,
        ),
        onPressed: () => Navigator.pushNamed(context, "/fav_books"));
  }

  Expanded buildBody() {
    return Expanded(
      flex: 11,
      child: Column(
        children: [
          //buildTopScreen(),
          buildMainPage(),
        ],
      ),
    );
  }

  Widget buildMainPage() {
    return Expanded(
      flex: 11,
      child: ListView(
        children: [
          buildText("Keşfet", 32, Colors.black),
          buildSizedBox(12),
          buildSplash(),
          buildSizedBox(12),
          buildRow(),
          buildListView(listBookService),
          buildSizedBox(12),
          buildText("Seçtiğiniz dilde kitaplar", 24, Colors.black),
          buildSizedBox(12),
          buildListView(listBookService),
          buildBottomBar(),
        ],
      ),
    );
  }

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildText("Popüler", 32, Colors.black),
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MoreBook()),
              ),
              child: Text("Daha Fazla"),
            ),
            buildIconButton(),
          ],
        ),
      ],
    );
  }

  Container buildSplash() {
    return Container(
      child: FutureBuilder(
        future: books.randomBookGenerate(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return randomBook == null
              ? Text("Yükleniyor")
              : GestureDetector(
                  onTap: () {
                    books.selectedBook = books.randomBook;
                    Navigator.pushNamed(context, "/book_detail");
                  },
                  child: newSplash(context, books.randomBook.imageLink),
                );
        },
      ),
    );
  }

  Widget buildListView(List<Book> bookService) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.bookList.length,
        itemBuilder: (BuildContext context, int index) {
          return bookService == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GestureDetector(
                  onTap: () {
                    books.selectedBook = bookService[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetail(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: buildBookImage(
                      context,
                      false,
                      125,
                      title: books.bookList[index].title,
                      imagePath: books.bookList[index].imageLink,
                    ),
                  ),
                );
        },
      ),
    );
  }

  IconButton buildIconButton() {
    return IconButton(
      icon: Icon(Icons.arrow_forward),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MoreBook()),
      ),
    );
  }

  Expanded buildTopScreen() {
    return Expanded(
      flex: 2,
      child: SingleChildScrollView(
        child: buildSearchBar(),
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
