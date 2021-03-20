import 'package:flutter/cupertino.dart';

class ImageEntity {
  final String id;
  final String title;
  final String description;
  final String author;
  final String thumb;
  final String url;

  ImageEntity(
      {@required this.id,
        @required this.title,
        @required this.description,
        @required this.author,
        @required this.thumb,
        @required this.url});

  factory ImageEntity.fromJSON(Map<String, dynamic> json) {
    return ImageEntity(
        id: json['id'],
        title: json['description'],
        description: json['alt_description'],
        author: json['user']['name'],
        thumb: json['urls']['thumb'],
        url: json['urls']['raw']);
  }

  @override
  String toString() {
    return 'ImageEntity{id: $id, title: $title, description: $description, author: $author, thumb: $thumb, url: $url}';
  }
}
