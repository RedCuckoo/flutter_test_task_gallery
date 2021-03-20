//import 'package:flutter/foundation.dart';

class ImageEntity{
  final String id;
  final String title;
  final String description;
  final String author;
  final String thumb;
  final String url;

//TODO: add required
  ImageEntity({ this.id, this.title, this.description,
       this.author, this.thumb, this.url});

  factory ImageEntity.fromJSON(Map<String, dynamic> json){
    return ImageEntity(
      id: json['id'],
      title: json['description'],
      description: json['alt_description'],
      author: json['user']['name'],
      thumb: json['urls']['thumb'],
      url: json['urls']['raw']
    );
  }

  @override
  String toString() {
    return 'ImageEntity{id: $id, title: $title, description: $description, author: $author, thumb: $thumb, url: $url}';
  }
}