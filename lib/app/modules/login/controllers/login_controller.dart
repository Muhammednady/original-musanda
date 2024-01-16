import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../../profile/controllers/profile_controller.dart';
import '../providers/login_provider.dart';

class LoginController extends GetxController {
  static LoginController get I => Get.put(LoginController());
  var isProcessing = false.obs;
  final box = GetStorage();
  final formLoginKey = GlobalKey<FormState>();

  RxBool obscureText = true.obs;

  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
    update();
  }

  Icon getIcon() {
    return Icon(
      obscureText.value ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: MYColor.icons,
    );
  }

  validatePhone(String value) {
    final regExp = RegExp(
      Constance.phoneRegExp,
      caseSensitive: false,
      multiLine: false,
    );
    if (value.isEmpty) {
      return "msg_plz_enter_phone".tr;
    } else if (!regExp.hasMatch(value)) {
      return "msg_plz_enter_correct_phone".tr;
    }
    return null;
  }

  validatePassword(String value) {
    if (value.isEmpty) {
      return "msg_plz_enter_password".tr;
    } else if (value.length < 6) {
      return "msg_plz_enter_at_least_6_char".tr;
    }
    return null;
  }

  Future<void> login() async {
    try {
      if (formLoginKey.currentState!.validate()) {
        Map data = {
          "phone": "+966${txtPhone.text}",
          "password": txtPassword.text,
          "device_token": box.read("fcm_token"),
        };

        log(data.toString());
        isProcessing(true);
        LoginProvider().postLogin(data).then(
          (res) {
            if (res.code == 1) {
              // NotificationController.I.showNotify(
              //   id: res.data!.id,
              //   title: '😍 ${'success_login'.tr}',
              //   body: '❤️ ${res.data!.name} ${'msg_success_login'.tr}',
              // );

              Map data = {
                "id": res.data!.id,
                "name": res.data!.name,
                "phone": res.data!.phone!.substring(4),
                "email": res.data!.email,
                "token": res.data!.token,
                "firebaseToken": "",
              };

              box.write('LOGIN_MODEL', data).then((value) {
                getName();
              });

              ProfileController.I.getProfile();

              isProcessing(false);

              LoginProvider().lookupUserCountry().then(
                (value) {
                  if (value == "SA") {
                    box.write('SA', true);
                    Get.offAllNamed(Routes.MAIN_HOME_PAGE);
                  } else {
                    Get.offAllNamed(Routes.MAIN_HOME_PAGE);
                  }
                },
              );
            }
          },
        );
      }
    } catch (e, s) {
      log(e.toString(), name: 'LoginController => logins()');
      isProcessing.value = false;

      await Sentry.captureException(e, stackTrace: s);
    }
  }

  Future<void> removeAccount() async {
    try {
      Map data = {};
      LoginProvider().removeAccount(data).then(
        (res) {
          if (res.code == 1) {
            box.remove('LOGIN_MODEL');
            Get.offAllNamed(Routes.LOGIN);
          }
        },
      );
    } catch (e, s) {
      log(e.toString(), name: 'LoginController => removeAccount()');
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  bool isSA() {
    if (box.hasData('SA')) {
      log(
        "SA: ${box.read('SA')}",
        name: "IS_SA",
      );
      return true;
    }
    LoginProvider().lookupUserCountry().then(
      (value) {
        if (value == "SA") {
          box.write('SA', true);
          return true;
        } else {
          box.remove('SA');
          return false;
        }
      },
    );

    return false;
  }

  bool isAuth() {
    if (box.hasData('LOGIN_MODEL')) {
      return true;
    }
    return false;
  }

  String? getName() {
    if (box.hasData('LOGIN_MODEL')) {
      var jsonString = box.read('LOGIN_MODEL');
      return jsonString['name'];
    }

    return "";
  }

  logout() async {
    box.remove('LOGIN_MODEL');
    box.remove('SA');
    mySnackBar(
      title: "success".tr,
      message: "msg_logout_success".tr,
      color: MYColor.success,
      icon: CupertinoIcons.check_mark_circled,
    );
    Future.delayed(const Duration(seconds: 1)).then((_) {
      Get.offAllNamed(Routes.LOGIN);
    });
    update();
  }
}
