import 'package:flutter/material.dart';
import 'package:swipedeletepullrefresh_demo/dashboard.dart';
import 'package:swipedeletepullrefresh_demo/viewTypeCallback.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> implements ViewTypeCallBack {
  Widget appBarTitle = new Text(
    "Home".toUpperCase(),
    overflow: TextOverflow.ellipsis,
  );
  Widget view;
  Dashboard dashboard;

  @override
  void initState() {
    super.initState();
    dashboard = Dashboard(this);
    view = Dashboard(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home",
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: appBarTitle,
          ),
          body: view,
        ),
      ),
    );
  }

  @override
  void viewType(Widget widget, String title) {
    if (title.contains("StreamBuilder")) {
      appBarTitle = Text("StreamBuilder");
      setState(() {
        this.view = widget;
      });
    } else if (title.contains("CounterClass")) {
      appBarTitle = Text("CounterBloc");
      setState(() {
        this.view = widget;
      });
    }
  }
}
