import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StreamBuilderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: "Working...",
      stream: _streamData(),
      builder: (context, snapshot) {
        return Scaffold(
            body: Center(
              child: Text(snapshot.data.toString()),
            ),
            floatingActionButton: FloatingActionButton(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () => print(snapshot.data.toString()),
              ),
              onPressed: () {},
            ));
      },
    );
  }

  Stream<int> _streamData() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      return a++;
    });
  }
}
