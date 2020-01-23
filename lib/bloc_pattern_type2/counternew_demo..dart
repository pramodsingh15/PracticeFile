import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipedeletepullrefresh_demo/bloc_pattern_demo/counter_event.dart';
import 'package:swipedeletepullrefresh_demo/bloc_pattern_type2/counter_bloc_demo.dart';

class CounterDemoBloc extends StatefulWidget {
  @override
  _CounterDemoBlocState createState() => _CounterDemoBlocState();
}

class _CounterDemoBlocState extends State<CounterDemoBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => CounterBlocDemo(),
      child: CounterScreen(),
    ));
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counterBloc = BlocProvider.of<CounterBlocDemo>(context);
    return Center(
      child: Column(
        children: <Widget>[
          BlocBuilder<CounterBlocDemo, int>(
            builder: (BuildContext context, int state) {
              return Text(
                "Count Value : $state",
                style: Theme.of(context).textTheme.display1,
              );
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("increment"),
                onPressed: () {
                  _counterBloc.add(CounterEvents.increment);
                },
              ),
              RaisedButton(
                child: Text("increment"),
                onPressed: () {
                  _counterBloc.add(CounterEvents.decrement);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
