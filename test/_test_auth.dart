import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musaneda/app/modules/login/login_model.dart';
import 'package:musaneda/app/modules/login/providers/login_provider.dart';
import 'package:musaneda/config/constance.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LoginProvider prd = LoginProvider();

  test("test auth login", () async {
    Login login = await prd.postLogin({
      "phone": "+966568970184",
      "password": "12345678",
      "device_token": "device-token",
    });

    expect(login, isA<Login>());
  });

  test("test auth register", () async {
    Pretty.instance.logger.d("test auth register");
  });
}
