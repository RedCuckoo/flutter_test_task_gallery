//import 'package:flutter/foundation.dart';

class Image{
  final String id;
  final String title;
  final String description;
  final String author;
  final String link;

//TODO: add required
  Image({ this.id, this.title, this.description,
       this.author, this.link});

  factory Image.fromJSON(Map<String, dynamic> json){
    return Image(
      id: json['id'],
      title: json['description'],
      description: json['alt_description'],
      author: json['user']['name'],
      link: json['urls']['small']
    );
  }

  @override
  String toString() {
    return 'Image{id: $id, title: $title, description: $description, author: $author, link: $link}';
  }
}