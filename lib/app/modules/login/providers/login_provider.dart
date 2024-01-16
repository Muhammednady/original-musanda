import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../login_model.dart';

class LoginProvider extends GetConnect {
  Future<Login> postLogin(Map data) async {
    try {
      final res = await post("${Constance.apiEndpoint}/login", data);

      Pretty.instance.logger.d(res.body);

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "msg_unauthorized".tr,
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );

        if (res.body['error']['unauthorized'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_unauthorized".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        // Phone number is not registered!
        if (res.body['error']['phone'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_phone_not_registered".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        // Password is incorrect!
        if (res.body['error']['password'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_password_incorrect".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_login_success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Login.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<Login> removeAccount(Map data) async {
    try {
      final res = await post(
        "${Constance.apiEndpoint}/remove_account",
        data,
        headers: {
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "msg_unauthorized".tr,
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
        if (res.body['error']['unauthorized'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_unauthorized".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        // Phone number is not registered!
        if (res.body['error']['phone'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_phone_not_registered".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        // Password is incorrect!
        if (res.body['error']['password'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_password_incorrect".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_remove_account_success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Login.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<String> lookupUserCountry() async {
    try {
      final res = await get("https://api.ipregistry.co?key=3z5yh8nwrlaasqaj");
      log(res.body['location']['country']['name'], name: 'IP_API_response_is');
      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return res.body['location']['country']['code'];
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
