import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipedeletepullrefresh_demo/models.dart';
import 'package:swipedeletepullrefresh_demo/services.dart';

class JsonDemo extends StatefulWidget {
  JsonDemo();
  @override
  _JsonDemoState createState() => _JsonDemoState();
}

class _JsonDemoState extends State<JsonDemo> {
  Future<String> loadPersonfromAssets() async {
    return await rootBundle.loadString('json/person.json');
  }

  Future loadPerson() async {
    String jsonString = await loadPersonfromAssets();
    final jsonResponse = jsonDecode(jsonString);
    Person person = Person.fromJson(jsonResponse);

    print("Name ---> ${person.name}");
    print("Places--->${person.places}");
    print("Images--->${person.images[0].name}");
    print("Address--->${person.address.details.town}");

    print("Loading Photos....");
    Services.getPhotos().then((albums) {
      print("Albums: ${albums.length}"); //${albums.elementAt(0).title}
    });
  }

  @override
  void initState() {
    super.initState();
    loadPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Parsing"),
      ),
      body: Container(
        child: Text("data"),
      ),
    );
  }
}
