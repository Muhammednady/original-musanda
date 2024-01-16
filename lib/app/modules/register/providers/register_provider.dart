import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:musaneda/config/myColor.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../register_model.dart';

class RegisterProvider extends GetConnect {
  Future<Register> postRegister(Map data) async {
    await EasyLoading.show(status: 'create'.tr);
    try {
      final res = await post("${Constance.apiEndpoint}/register", data);

      await EasyLoading.dismiss();

      if (res.body['code'] == 0) {
        // Name is required
        if (res.body['data']['name'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_plz_enter_full_name".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        // Phone number already exists!
        if (res.body['data']['phone'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_phone_already_exist".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        // Email already exists!
        if (res.body['data']['email'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_email_already_exist".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        // Iqama number already exists!
        if (res.body['data']['iqama'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_iqama_already_exist".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_register_success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.check_mark_circled,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Register.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<int> postVerify(Map data) async {
    await EasyLoading.show(status: 'verify'.tr);
    try {
      final res = await post("${Constance.apiEndpoint}/verify_otp", data);

      await EasyLoading.dismiss();

      if (res.body['code'] == 0) {
        // Verification code is required
        if (res.body['data']['code'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_plz_enter_verification_code".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        // Verification code is invalid
        if (res.body['data']['code'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_verification_code_is_invalid".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_verification_success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.check_mark_circled,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return res.body['code'];
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<int> postResendOtp(Map data) async {
    await EasyLoading.show(status: 'create'.tr);
    try {
      final res = await post("${Constance.apiEndpoint}/send_otp", data);

      await EasyLoading.dismiss();

      if (res.body['code'] == 0) {
        // Phone number already exists!
        if (res.body['data']['phone'] != null) {
          mySnackBar(
            title: "error".tr,
            message: "msg_phone_already_exist".tr,
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "msg_register_success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.check_mark_circled,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return res.body['code'];
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
