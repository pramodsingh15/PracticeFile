import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:swipedeletepullrefresh_demo/login_bloc_pattern/validator.dart';

class Bloc extends Object with Validators implements BaseBloc {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  Stream<String> get email =>
      _emailController.stream.transform(emailValidators);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidators);

  Stream<bool> get submitCheck =>
      Rx.combineLatest2(email, password, (e, p) => true);


  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
