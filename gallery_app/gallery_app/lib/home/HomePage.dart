import 'package:flutter/material.dart';
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

  void _loadImages(){
    print("load");
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
    print("build func");
    // print(images);

    return Scaffold(
        body: ListView.builder(
          itemCount: images.length+1,
          itemBuilder: (context, index){
            print("build");
            if (index >= images.length){
              if (!_loading){
                _loadImages();
              }
              return Center(child: CircularProgressIndicator());
            }
            return _buildRow(images[index]);
          },
        )
    );
  }

  Widget _buildRow(ImageEntity image) {
    String toShow;
    if (image.title == null) {
      toShow = image.description;
    } else {
      toShow = image.title;
    }

    if (toShow == null) {
      toShow = "No title/description provided";
    }

    return ListTile(
        title: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
                child: Image.network(image.thumb),
              padding:EdgeInsets.all(4.0)
            )
          ),
          Expanded(
            flex:3,
            child: Padding(
              child: Column(
              children: [
                Text(toShow),
                Text(image.author)
              ],
            ),
            padding: EdgeInsets.all(4.0)
            )
          )
        ],
      ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return ImageScreen(imageEntity: image);
          }));}
    );

    // return ListTile(
    //   title: Column(children: <Widget>[ Text(toShow), Text(image.author)]),
    //   leading: Padding(child: Image.network(image.thumb), padding: EdgeInsets.all(3.0)),
    //   onTap: (){
    //     print("Tap");
    //     Navigator.push(context, MaterialPageRoute(builder: (_){
    //       return ImageScreen(imageEntity: image);
    //     }));
    //     },);
  }
}