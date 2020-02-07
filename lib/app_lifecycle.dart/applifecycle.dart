import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:swipedeletepullrefresh_demo/app_lifecycle.dart/stateful_lifecycle.dart';
import 'package:swipedeletepullrefresh_demo/viewTypeCallback.dart';

class AppLifeCycleClass extends StatefulWidget {
  ViewTypeCallBack callBack;
  AppLifeCycleClass(this.callBack);
  @override
  _AppLifeCycleClassState createState() => _AppLifeCycleClassState();
}

class _AppLifeCycleClassState extends State<AppLifeCycleClass>
    with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // getDeviceInfo();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // this method called in AppLifecycleState.paused state
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
      print("My App State: $_appLifecycleState");
    });

    for (int i = 0; i < 5; i++) {
      print("Value in onPause Sate : $i");
    }
  }

  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text("AppLifeCycle State",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(_appLifecycleState.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: orientation == Orientation.portrait
                            ? Colors.blue
                            : Colors.red)),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  child: FlatButton(
                      color: Colors.cyanAccent,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StateFulLifeCycleClass()));
                      },
                      child: Text("Go to StateFulLife cycle Class")),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
