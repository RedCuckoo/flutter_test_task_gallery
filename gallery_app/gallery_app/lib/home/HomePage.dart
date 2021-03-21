import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_app/entity/ImageEntity.dart';
import 'package:gallery_app/util/PhotosRetriever.dart';

import 'ImageScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ImageEntity> images = [];

  int _page = 1;
  bool _loading = true;

  void _loadImages() {
    _loading = true;
    PhotosRetriever.getImagesList(_page++).then((value) {
      setState(() {
        _loading = false;
        images.addAll(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    _loadImages();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "Gallery App",
            style: TextStyle(
              fontFamily: 'Monospace',
              fontSize: 20,
            ),
          )),
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
          itemCount: images.length + 1,
          itemBuilder: (context, index) {
            if (index >= images.length) {
              if (!_loading) {
                _loadImages();
              }
              return Center(child: CircularProgressIndicator());
            }
            return _buildRow(images[index]);
          },
        ));
  }

  Widget _buildRow(ImageEntity image) {
    String toShow;
    if (image.title == null) {
      if (image.description == null) {
        toShow = "No title/description provided";
      } else {
        toShow = 'Description: ' + image.description;
      }
    } else {
      toShow = 'Title: ' + image.title;
    }

    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Padding(
                  child: GestureDetector(
                      child: Image.network(image.thumb, loadingBuilder:
                          (BuildContext context, Widget child,
                              ImageChunkEvent loadingProcess) {
                        if (loadingProcess == null) {
                          return child;
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ImageScreen(imageEntity: image);
                        }));
                      }),
                  padding: EdgeInsets.all(4.0))),
          Expanded(
              flex: 3,
              child: Padding(
                  child: Column(
                    children: [
                      Padding(
                          child: Text(
                            toShow,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Monospace', fontSize: 18),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 4.0)),
                      Padding(
                          child: Text(
                            "\u00a9" + image.author,
                            style: TextStyle(
                                fontFamily: 'Monospace', fontSize: 14),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 4.0))
                    ],
                  ),
                  padding: EdgeInsets.all(4.0)))
        ],
      ),
    );
  }
}
