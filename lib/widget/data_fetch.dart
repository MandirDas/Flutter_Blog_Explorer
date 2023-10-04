// To parse this JSON data, do
//
//     final blogfetch = blogfetchFromJson(jsonString);

import 'dart:convert';
class Blog {
  String id;
  String title;
  String image_url;

  Blog({
    required this.id,
    required this.title,
    required this.image_url,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json["id"],
    title: json["title"],
    image_url: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image_url": image_url,
  };
}
