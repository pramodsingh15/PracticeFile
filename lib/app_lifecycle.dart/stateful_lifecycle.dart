import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

class StateFulLifeCycleClass extends StatefulWidget {
  @override
  _StateFulLifeCycleClassState createState() => _StateFulLifeCycleClassState();
}

class _StateFulLifeCycleClassState extends State<StateFulLifeCycleClass> {
  _StateFulLifeCycleClassState() {
    print("Widget state constructor");
  }
  @override
  void initState() {
    print("From initState");
    super.initState();
    // getDeviceInfo();
  }

  @override
  void dispose() {
    print("From dispose method");
    super.dispose();
  }

  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
  }

  @override
  Widget build(BuildContext context) {
    print("From state build");
    return MaterialApp(
      title: "StateFulLife cycle",
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("StateFulLife cycle")),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text("StateFul LifeCycle",
                        style: TextStyle(
                            fontSize: 20,
                            color: orientation == Orientation.portrait
                                ? Colors.blue
                                : Colors.red)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(StateFulLifeCycleClass oldWidget) {
    print("From  State didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }
}
