import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/assets/model/book_data.dart';
import 'package:provider_sample/provider/book_provider.dart';
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
  BookProvider books;

  @override
  Widget build(BuildContext context) {
    books = Provider.of<BookProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          buildBody(),
        ],
      ),
    );
  }

  Expanded buildBody() {
    return Expanded(
      flex: 11,
      child: Column(
        children: [
          searchBar(),
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
          buildText("Keşfet", 32, Colors.black, FontWeight.w800),
          buildSizedBox(12),
          buildSplash(),
          buildSizedBox(12),
          buildRow(),
          buildListView(books.allBooks(), true),
          buildSizedBox(12),
          buildText(
              "Seçtiğiniz dilde kitaplar", 24, Colors.black, FontWeight.w800),
          buildSizedBox(12),
          buildListView(books.queryByLanguage(), false),
          buildBottomBar(),
        ],
      ),
    );
  }

  Container buildSplash() {
    return Container(
      child: FutureBuilder(
        future: books.randomBookGenerate(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: () {
                    books.selectedBook = snapshot.data;
                    Navigator.pushNamed(context, "/book_detail");
                  },
                  child: newSplash(context, snapshot.data.imageLink),
                );
        },
      ),
    );
  }

  Widget buildListView(Future<List<Book>> bookList, bool allBooks) {
    return Container(
        height: MediaQuery.of(context).size.height / 3.2,
        child: FutureBuilder(
            future: bookList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return !snapshot.hasData
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: allBooks == true ? 6 : snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return snapshot.data == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : GestureDetector(
                                onTap: () {
                                  books.selectedBook = snapshot.data[index];
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
                                    title: snapshot.data[index].title,
                                    imagePath: snapshot.data[index].imageLink,
                                  ),
                                ),
                              );
                      },
                    );
            }));
  }

  Widget buildBottomBar() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildIconAddFav(),
        ],
      ),
    );
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

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildText("Popüler", 32, Colors.black, FontWeight.w800),
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

  IconButton buildIconButton() {
    return IconButton(
      icon: Icon(Icons.arrow_forward),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MoreBook()),
      ),
    );
  }

  Widget searchBar() {
    return Consumer<BookProvider>(
      builder: (BuildContext context, BookProvider provider, Widget child) {
        return Container(
          margin: EdgeInsets.only(top: 35),
          child: Expanded(
            flex: 2,
            child: InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text("İstediğiniz dile göre kitap arayın"),
                  value: provider.selectedLanguage,
                  isDense: true,
                  onChanged: (newValue) {
                    provider.dropdownButtonValueChange(newValue);
                    provider.queryByLanguage();
                  },
                  items: provider.languageMap.entries
                      .map(
                        (MapEntry element) => DropdownMenuItem(
                          value: element.value,
                          child: Text(element.key),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
