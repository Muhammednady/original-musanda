import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/profile/profile_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';

class ProfileProvider extends GetConnect {
  Future<Profile> getProfile() async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/profile",
        headers: {
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "System Error",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Profile.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  postProfile(Map data) async {
    try {
      final res = await put(
        "${Constance.apiEndpoint}/profile",
        data,
        headers: {
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        if (res.body['error']['name'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['error']['name'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        if (res.body['error']['email'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['error']['email'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        if (res.body['error']['phone'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['error']['phone'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        if (res.body['error']['password'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['error']['password'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_update_success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.check_mark_circled,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Profile.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
