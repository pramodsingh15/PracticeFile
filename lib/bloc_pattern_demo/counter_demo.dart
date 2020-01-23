import 'package:flutter/material.dart';
import 'package:swipedeletepullrefresh_demo/bloc_pattern_demo/counter_bloc.dart';
import 'package:swipedeletepullrefresh_demo/bloc_pattern_demo/counter_event.dart';

class CounterClass extends StatefulWidget {
  @override
  _CounterClassState createState() => _CounterClassState();
}

class _CounterClassState extends State<CounterClass> {
  final _bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: StreamBuilder(
        stream: _bloc.counter,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You have pushed the button this many times"),
              Text(
                "${snapshot.data}",
                style: Theme.of(context).textTheme.display1,
              )
            ],
          );
        },
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _bloc.counterEventSink.add(IncrementEvent());
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              _bloc.counterEventSink.add(DecrementEvent());
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
