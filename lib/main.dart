import 'package:flutter/material.dart';
import 'package:provider_sample/book_detail.dart';
import 'package:provider_sample/more_book.dart';
import 'package:provider_sample/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildBody(),
          buildBottomBar(),
        ],
      ),
    );
  }

  Expanded buildBottomBar() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildIconAddFav(),
            buildIconUserPrefs(),
          ],
        ),
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
          Icons.library_add,
          size: 40,
          color: Colors.grey,
        ),
        onPressed: null);
  }

  Expanded buildBody() {
    return Expanded(
      flex: 11,
      child: Column(
        children: [
          buildTopScreen(),
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
          buildBookImage(context, true, 485,
              author: "Ernest Hemingway",
              title: "For Whom the Bell Tolls",
              imagePath: "lib/assets/images/51frUNw6i9L.jpg"),
          buildSizedBox(12),
          Row(
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
                  IconButton(icon: Icon(Icons.arrow_forward), onPressed: null),
                ],
              ),
            ],
          ),
          buildBookHorizontalListView1(context),
          buildSizedBox(12),
          buildText("Seçtiğiniz dilde kitaplar", 24, Colors.black),
          buildSizedBox(12),
          buildBookHorizontalListView1(context),
        ],
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
