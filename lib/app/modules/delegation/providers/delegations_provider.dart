import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../delegations_model.dart';

class DelegationsProvider extends GetConnect {
  Future<Delegations> getDelegations() async {
    await EasyLoading.show(status: 'waiting'.tr);

    try {
      final res = await get(
        "${Constance.apiEndpoint}/delegations",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      await EasyLoading.dismiss();

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Delegations.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<bool> deleteDelegation(int i) async {
    try {
      delete(
        "${Constance.apiEndpoint}/delegations/$i",
        headers: {
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      ).then((value) {
        if (value.body['code'] == 0) {
          mySnackBar(
            title: "error".tr,
            message: "msg_delegation_delete_failed".tr,
            color: MYColor.error,
            icon: CupertinoIcons.xmark_circle,
          );
          return false;
        }
        if (value.body['code'] == 1) {
          mySnackBar(
            title: "success".tr,
            message: "msg_delegation_deleted".tr,
            color: MYColor.success,
            icon: CupertinoIcons.checkmark_alt,
          );
          getDelegations();
          return true;
        }
      });

      return Future.value(true);
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  statusDelegation(int i, status) async {
    try {
      post(
        "${Constance.apiEndpoint}/delegations/$i/status",
        headers: {
          "Authorization": "Bearer ${Constance.instance.token}",
        },
        {"status": status},
      ).then(
        (value) {
          if (value.body['code'] == 0) {
            mySnackBar(
              title: "error".tr,
              message: "msg_delegation_status_failed".tr,
              color: MYColor.error,
              icon: CupertinoIcons.xmark_circle,
            );
            return false;
          }
          if (value.body['code'] == 1) {
            mySnackBar(
              title: "success".tr,
              message: "msg_delegation_status_changed".tr,
              color: MYColor.success,
              icon: CupertinoIcons.checkmark_alt,
            );
            getDelegations();
            return true;
          }
        },
      );

      return Future.value(true);
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  updateDelegation(Map body, int i) async {
    try {
      put(
        "${Constance.apiEndpoint}/delegations/$i",
        headers: {
          "Authorization": "Bearer ${Constance.instance.token}",
        },
        body,
      ).then(
        (value) {
          if (value.body['code'] == 0) {
            mySnackBar(
              title: "error".tr,
              message: "msg_delegation_update_failed".tr,
              color: MYColor.error,
              icon: CupertinoIcons.xmark_circle,
            );
            return false;
          }
          if (value.body['code'] == 1) {
            mySnackBar(
              title: "success".tr,
              message: "msg_delegation_updated".tr,
              color: MYColor.success,
              icon: CupertinoIcons.checkmark_alt,
            );
            getDelegations();
            return true;
          }
        },
      );

      return Future.value(true);
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  postDelegation(Map body) async {
    try {
      post(
        "${Constance.apiEndpoint}/delegations",
        headers: {
          "Authorization": "Bearer ${Constance.instance.token}",
        },
        body,
      ).then(
        (value) {
          if (value.body['code'] == 0) {
            mySnackBar(
              title: "error".tr,
              message: "msg_delegation_create_failed".tr,
              color: MYColor.error,
              icon: CupertinoIcons.xmark_circle,
            );
            return false;
          }
          if (value.body['code'] == 1) {
            mySnackBar(
              title: "success".tr,
              message: "msg_delegation_created".tr,
              color: MYColor.success,
              icon: CupertinoIcons.checkmark_alt,
            );
            getDelegations();
            return true;
          }
        },
      );

      return Future.value(true);
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
