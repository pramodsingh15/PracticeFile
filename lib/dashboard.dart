import 'package:flutter/material.dart';
import 'package:swipedeletepullrefresh_demo/app_lifecycle.dart/applifecycle.dart';
import 'package:swipedeletepullrefresh_demo/app_lifecycle.dart/stateful_lifecycle.dart';
import 'package:swipedeletepullrefresh_demo/bloc_pattern_demo/counter_bloc.dart';
import 'package:swipedeletepullrefresh_demo/bloc_pattern_demo/counter_demo.dart';
import 'package:swipedeletepullrefresh_demo/bloc_pattern_type2/counternew_demo..dart';
import 'package:swipedeletepullrefresh_demo/dashboard_modal.dart';
import 'package:swipedeletepullrefresh_demo/login_bloc_pattern/login_main.dart';
import 'package:swipedeletepullrefresh_demo/streambuild_futureBuilder.dart';
import 'package:swipedeletepullrefresh_demo/streambuilder_counterdemo.dart';
import 'package:swipedeletepullrefresh_demo/streambuilderdemo.dart';
import 'package:swipedeletepullrefresh_demo/values/appstrings.dart';
import 'package:swipedeletepullrefresh_demo/viewTypeCallback.dart';

class Dashboard extends StatefulWidget {
  ViewTypeCallBack callBack;
  Dashboard(this.callBack);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            mainAxisSpacing: 20,
            physics: ScrollPhysics(),
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            children: List.generate(choices.length, (index) {
              return Center(
                child: InkWell(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image(
                          image: AssetImage(choices[index].imageName),
                          color: choices[index].colorName,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 70,
                          child: Text(
                            choices[index].title,
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    String title = choices[index].title;
                    if (title == AppStrings.LABEL_STREAM_BUILDER) {
                      this.widget.callBack.viewType(StreamBuilderDemo(), title);
                    } else if (title == "CounterClass") {
                      this.widget.callBack.viewType(CounterClass(), title);
                    } else if (title == "CounterBlocDemo") {
                      this.widget.callBack.viewType(CounterDemoBloc(), title);
                    } else if (title == "StreamFutureBuilder") {
                      this
                          .widget
                          .callBack
                          .viewType(StreamFutureBuilder(), title);
                    } else if (title == "LoginBloc") {
                      this.widget.callBack.viewType(
                          LoginMain(this.widget.callBack), "LoginBloc");
                    } else if (title == "AppLifeCycle") {
                      this.widget.callBack.viewType(
                          AppLifeCycleClass(this.widget.callBack),
                          "AppLifeCycle");
                    } else if (title == "StreambuilderCounter") {
                      this.widget.callBack.viewType(
                          StreamBuilderCounter(),
                          "StreambuilderCounter");
                    }
                  },
                ),
              );
            }),
          ))
        ],
      ),
    );
  }
}

const List<DashBoardModal> choices = const <DashBoardModal>[
  const DashBoardModal(
      title: AppStrings.LABEL_STREAM_BUILDER,
      imageName: "images/logo.png",
      colorName: Colors.teal),
  const DashBoardModal(
      title: AppStrings.LABEL_STREAM_CONTROLLER,
      imageName: "images/logo.png",
      colorName: Colors.red),
  const DashBoardModal(
      title: "MixinDemo", imageName: "images/logo.png", colorName: Colors.teal),
  const DashBoardModal(
      title: "ServicesJsonDemo",
      imageName: "images/logo.png",
      colorName: Colors.red),
  const DashBoardModal(
      title: "StreambuilderCounter",
      imageName: "images/logo.png",
      colorName: Colors.teal),
  const DashBoardModal(
      title: "JsonDemo", imageName: "images/logo.png", colorName: Colors.red),
  const DashBoardModal(
      title: "SwipeDeletePullRefresh",
      imageName: "images/logo.png",
      colorName: Colors.red),
  const DashBoardModal(
      title: "CounterClass",
      imageName: "images/logo.png",
      colorName: Colors.cyan),
  const DashBoardModal(
      title: "CounterBlocDemo",
      imageName: "images/logo.png",
      colorName: Colors.cyanAccent),
  const DashBoardModal(
      title: "StreamFutureBuilder",
      imageName: "images/logo.png",
      colorName: Colors.green),
  const DashBoardModal(
      title: "LoginBloc",
      imageName: "images/logo.png",
      colorName: Colors.greenAccent),
  const DashBoardModal(
      title: "AppLifeCycle",
      imageName: "images/logo.png",
      colorName: Colors.cyan)
];
