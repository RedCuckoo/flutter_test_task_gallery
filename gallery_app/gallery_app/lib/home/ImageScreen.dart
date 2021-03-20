import 'package:flutter/material.dart';
import 'package:gallery_app/entity/ImageEntity.dart';

class ImageScreen extends StatefulWidget{
  final ImageEntity imageEntity;

  ImageScreen({@required this.imageEntity});

  @override
  _ImageScreenState createState() => _ImageScreenState(imageEntity: imageEntity);
}

class _ImageScreenState extends State<ImageScreen>{
  final ImageEntity imageEntity;

  _ImageScreenState({@required this.imageEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GestureDetector(
        child: Center(
            child:Image.network(imageEntity.url + "&w=" + MediaQuery.of(context).size.width.toString(),
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProcess){
                  if (loadingProcess == null){
                    return child;
                  }
                  return Center(child: CircularProgressIndicator());
                }
                ,)
        ),
        onTap: (){
          Navigator.pop(context);
        },
      )
    );
  }
  
}