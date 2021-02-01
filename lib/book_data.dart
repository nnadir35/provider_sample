// To parse this JSON data, do
//
//     final books = booksFromJson(jsonString);

import 'dart:convert';

Book booksFromJson(String str) => Book.fromJson(json.decode(str));

String booksToJson(Book data) => json.encode(data.toJson());

class Book {
  Book({
    this.author,
    this.country,
    this.imageLink,
    this.language,
    this.pages,
    this.title,
    this.year,
  });

  String author;
  String country;
  String imageLink;
  String language;
  String pages;
  String title;
  String year;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        author: json["author"],
        country: json["country"],
        imageLink: json["imageLink"],
        language: json["language"],
        pages: json["pages"].toString(),
        title: json["title"],
        year: json["year"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "country": country,
        "imageLink": imageLink,
        "language": language,
        "pages": pages,
        "title": title,
        "year": year,
      };
}
