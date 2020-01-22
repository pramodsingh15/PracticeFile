import 'package:flutter/material.dart';

class StreamBuilderCounter extends StatefulWidget {
  @override
  _StreamBuilderCounterState createState() => _StreamBuilderCounterState();
}

class _StreamBuilderCounterState extends State<StreamBuilderCounter> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      home: StreamCounterClass(),
      
    );
  }
}

class StreamCounterClass extends StatefulWidget {
  @override
  _StreamCounterClassState createState() => _StreamCounterClassState();
}

class _StreamCounterClassState extends State<StreamCounterClass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
