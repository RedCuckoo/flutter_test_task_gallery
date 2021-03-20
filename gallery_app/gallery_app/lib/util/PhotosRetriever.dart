import 'dart:convert';

import 'package:gallery_app/entity/ImageEntity.dart';
import 'package:http/http.dart' as http;

class PhotosRetriever {
  static Future<List<dynamic>> _getPhotos(int page) async {
    final response = await http.get(Uri.http('api.unsplash.com', '/photos', {
      'client_id': 'lEShO8Ly_Jky08WQyd2ut2iKbl_Ul4wdpo6vrWAtpL8',
      'page': page.toString()
    }));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load list');
    }
  }

  static Future<List<ImageEntity>> getImagesList(int page) async {
    List<dynamic> jsonList = await PhotosRetriever._getPhotos(page);
    List<ImageEntity> images = [];

    for (int i = 0; i < jsonList.length; ++i) {
      images.add(new ImageEntity.fromJSON(jsonList[i]));
    }

    return images;
  }
}
