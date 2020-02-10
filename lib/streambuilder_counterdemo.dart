import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilderCounter extends StatefulWidget {
  @override
  _StreamBuilderCounterState createState() => _StreamBuilderCounterState();
}

class _StreamBuilderCounterState extends State<StreamBuilderCounter> {
  StreamController<int> _streamController = StreamController<int>();
  int _counter = 0;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  return Text("You pushed ${snapshot.data} times");
                }),
            FlatButton(
              onPressed: () {
                _streamController.sink.add(_counter++);
              },
              child: Text("Press Here"),
              color: Colors.cyanAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}
