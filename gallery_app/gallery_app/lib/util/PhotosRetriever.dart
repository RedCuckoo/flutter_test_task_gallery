import 'dart:convert';

import 'package:gallery_app/entity/Image.dart';
import 'package:http/http.dart' as http;

class PhotosRetriever {
    static Future<List<dynamic>> _getPhotos() async{
    final response = await http.get(
      Uri.http('api.unsplash.com', '/photos',
          {'client_id' : 'YOUR ACCESS KEY'})
    );

    if (response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception('Failed to load list');
    }

  }

  static Future<List<Image>> getImagesList() async{
    List<dynamic> jsonList = await PhotosRetriever._getPhotos();
    List<Image> images = [];

    for (int i = 0; i < jsonList.length; ++i){
      images.add(new Image.fromJSON(jsonList[i]));
      print(images[i].toString());
    }

    return images;
  }
}