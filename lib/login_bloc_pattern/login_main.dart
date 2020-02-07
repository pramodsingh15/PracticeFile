import 'package:flutter/material.dart';
import 'package:swipedeletepullrefresh_demo/login_bloc_pattern/PageTwo.dart';
import 'package:swipedeletepullrefresh_demo/login_bloc_pattern/bloc_modal.dart';
import 'package:swipedeletepullrefresh_demo/viewTypeCallback.dart';

class LoginMain extends StatefulWidget {
  ViewTypeCallBack callBack;
  LoginMain(this.callBack);
  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final bloc = Bloc();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            StreamBuilder<String>(
                stream: bloc.email,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter email",
                        errorText: snapshot.error),
                    onChanged: bloc.emailChanged,
                  );
                }),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<String>(
                stream: bloc.password,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter password",
                        errorText: snapshot.error),
                    onChanged: bloc.passwordChanged,
                  );
                }),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
                stream: bloc.submitCheck,
                builder: (context, snapshot) {
                  return FlatButton(
                    color: Colors.cyanAccent,
                    onPressed:
                        snapshot.hasData ? () => changedThePage(context) : null,
                    child: Text(
                      "Submit",
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  changedThePage(context) {
    this.widget.callBack.viewType(PageTwoClass(), "PageTwo");
  }
}
