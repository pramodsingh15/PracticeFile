import 'dart:async';

import 'dart:math';

mixin Validators {
  var emailValidators =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains("@")) {
      sink.add(email);
    } else {
      sink.addError("Email is invalid");
    }
  });

  var passwordValidators = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 4) {
      sink.add(password);
    } else {
      sink.add("Password length should be more than 4 charachters");
    }
  });
}
