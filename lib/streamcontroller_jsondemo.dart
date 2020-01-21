import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StreamControllerDemo extends StatefulWidget {
  @override
  _StreamControllerDemoState createState() => _StreamControllerDemoState();
}

class _StreamControllerDemoState extends State<StreamControllerDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      home: StreamPhotoList(),
    );
  }
}

class StreamPhotoList extends StatefulWidget {
  @override
  _StreamPhotoListState createState() => _StreamPhotoListState();
}

class _StreamPhotoListState extends State<StreamPhotoList> {
  String url = "https://jsonplaceholder.typicode.com/photos";
  StreamController<Photo> _streamController = StreamController.broadcast();
  List<Photo> list = [];
  @override
  void initState() {
    super.initState();
    _streamController.stream.listen((photo) {
      setState(() {
        list.add(photo);
      });
    });
    load(_streamController);
  }

  load(StreamController<Photo> sc) async {
    var client = http.Client();
    var req = http.Request('get', Uri.parse(url));
    var streamCont = await client.send(req);
    streamCont.stream
        .transform(Utf8Decoder())
        .transform(JsonDecoder())
        .expand((e) => e)
        .map((map) => Photo.fromJson(map))
        .pipe(sc);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stream Controller"),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return _makeElement(index);
            },
          ),
        ),
      ),
    );
  }

  Widget _makeElement(int index) {
    if (index > list.length) {
      return null;
    } else {
      return Container(
        child: Card(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              children: <Widget>[
                Text(list[index].title),
                Image.network(list[index].url),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _streamController?.close();
    _streamController = null;
    super.dispose();
  }
}

class Photo {
  final String title;
  final String url;

  Photo({this.title, this.url});

  factory Photo.fromJson(Map map) {
    return Photo(title: map['title'], url: map['url']);
  }
}
