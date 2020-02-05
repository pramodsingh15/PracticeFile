import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swipedeletepullrefresh_demo/jsonDemo.dart';

class SwipeDeletePullRefreshDemo extends StatefulWidget {
  @override
  _SwipeDeletePullRefreshDemoState createState() =>
      _SwipeDeletePullRefreshDemoState();
}

class _SwipeDeletePullRefreshDemoState
    extends State<SwipeDeletePullRefreshDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Swipe Delete", home: SwipeClass());
  }
}

class SwipeClass extends StatefulWidget {
  @override
  _SwipeClassState createState() => _SwipeClassState();
}

class _SwipeClassState extends State<SwipeClass> {
  List<String> companies;

  GlobalKey<RefreshIndicatorState> refreshKey;
  Random randomValue;
  List<String> list1 = [];
  List<String> listStreamController = [];

  //two types of streams:
// 1) single-subscription streams and
// 2) BroadCast streams

// 1) single-subscription streams --- single subscription is there
  StreamController<List<String>> _streamController = StreamController();

  // 2) BroadCast streams ----Multiple susbcription is there
  StreamController<String> _broadcastStreamController =
      new StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    companies = List();
    randomValue = Random();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    addcompanies();

    _getSimpleStream();
    _getStreamController();
    _getBoradcastStream();
  }

  _getSimpleStream() {
    print("------------------------->");
    print("Creating a simple stream...");
    Stream<List<String>> stream = new Stream.fromFuture(getData());
    stream.listen((data) {
      for (var data1 in data) {
        print("Data received: " + data1);
      }
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("some error" + error);
    });

    print("simple stream code is here");
  }

  Future<List<String>> getData() async {
    await Future.delayed(Duration(seconds: 5));
    print("Fetched Data");
    String str = "This is test data";
    String str1 = "This is demo";
    list1.add(str);
    list1.add(str1);

    return list1;
  }

//1) single-subscription streams
  _getStreamController() {
    print("------------------->");
    print("Creating a stream controller....");
    _streamController.stream.listen((data) {
      // print("Data Received:" + data);
      for (var data1 in data) {
        print("Data received: " + data1);
      }
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("some error" + error);
    });

    String str = "This is 123 test data from streamcontroller";
    String str1 = "This is 456 demo data from streamcontroller";
    listStreamController.add(str);
    listStreamController.add(str1);
    _streamController.add(listStreamController);

    print("stream code controller is here");
  }

//2) BroadCasts streams --- Multiple subscriptions stream
  _getBoradcastStream() {
    print("------------------------>");
    print("Creating a streamController broadcasts");

    //first subscription
    _broadcastStreamController.stream.listen((data) {
      print("Data received: BroadCasts1-->" + data);
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("some error" + error);
    });

    //second subscription
    _broadcastStreamController.stream.listen((data) {
      print("Data received: BroadCasts2-->" + data);
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("some error" + error);
    });

    _broadcastStreamController.add("This is broadcasts data");
    print("stream broadcasts controller code is here");
  }

  addcompanies() {
    companies.add("Apple");
    companies.add("Amazon");
    companies.add("Facebook");
    companies.add("Oppo");
    companies.add("Twitter");
  }

  addRandomCompany() {
    int nextCount = randomValue.nextInt(100);
    setState(() {
      companies.add("Company $nextCount ");
    });
  }

  removeComapny(index) {
    setState(() {
      companies.removeAt(index);
    });
  }

  undoDelete(index, company) {
    setState(() {
      companies.insert(index, company);
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    addRandomCompany();
    return null;
  }

  showSnackBar(context, company, index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("$company deleted"),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {
          undoDelete(index, company);
        },
      ),
    ));
  }

  Widget refreshBg() {
    return Container(
      alignment: Alignment.centerRight,
      color: Colors.red,
      padding: EdgeInsets.only(right: 20),
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (BuildContext context, int index) {
        return row(context, index);
      },
    );
  }

  Widget row(context, index) {
    return Dismissible(
      key: Key(companies[index]),
      onDismissed: (direction) {
        var company = companies[index];
        showSnackBar(context, company, index);             
        removeComapny(index);
      },
      background: refreshBg(),
      child: Card(
        child: ListTile(
          title: Text(companies[index]),
        ),
      ),
    );
  }

  void _showModal() {
    Future<void> future = showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("This is modal bottom sheet"),
                  )),
            ),
          );
        });
    future.then((value) => _closeModal(value)); // return callback
  }

  void _closeModal(void value) {
    print('modal closed');
  }

  @override
  Widget build(BuildContext context) {
    // refreshKey.currentState.show(atTop: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Swipe Delete Pull Refresh"),
        ),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            await refreshList();
          },
          child: list(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showModal();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => JsonDemo()));
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close(); //stream must be closed when not needed
    _broadcastStreamController.close();
    super.dispose();
  }
}
