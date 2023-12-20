// To parse this JSON data, do
//
//     final bookItem = bookItemFromJson(jsonString);

import 'dart:convert';

List<BookItem> bookItemFromJson(String str) => List<BookItem>.from(json.decode(str).map((x) => BookItem.fromJson(x)));

String bookItemToJson(List<BookItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookItem {
    String? id;
    String? documentUrl;
    String? title;
    String? cover;

    BookItem({
        this.id,
        this.documentUrl,
        this.title,
        this.cover,
    });

    factory BookItem.fromJson(Map<String, dynamic> json) => BookItem(
        id: json["id"],
        documentUrl: json["document_url"],
        title: json["title"],
        cover: json["cover"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "document_url": documentUrl,
        "title": title,
        "cover": cover,
    };
}
