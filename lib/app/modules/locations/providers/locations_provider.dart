import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../locations_model.dart';

class LocationsProvider extends GetConnect {
  final box = GetStorage();

  Future<Locations> getLocations() async {
    await EasyLoading.show(status: 'waiting'.tr);
    try {
      final res = await get(
        "${Constance.apiEndpoint}/locations",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      await EasyLoading.dismiss();

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Locations.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<int> postLocations(Map data) async {
    await EasyLoading.show(status: 'waiting'.tr);
    try {
      final res = await post(
        "${Constance.apiEndpoint}/locations",
        data,
        headers: {
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      await EasyLoading.dismiss();
      if (res.body['code'] == 0) {
        if (res.body['data']['city'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['data']['city'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['country'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['data']['country'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['address'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['data']['address'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['title'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['data']['title'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['notes'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['data']['notes'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['latitude'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['data']['latitude'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }

        if (res.body['data']['longitude'] != null) {
          mySnackBar(
            title: "error".tr,
            message: res.body['data']['longitude'][0],
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        return res.body['code'];
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.info_circle,
        );

        return res.body['code'];
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

  Future<int> deleteLocations(id) async {
    await EasyLoading.show(status: 'waiting'.tr);
    try {
      final res = await delete(
        "${Constance.apiEndpoint}/locations/$id",
        headers: {
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      await EasyLoading.dismiss();
      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "System error".tr,
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "success".tr,
          message: "success".tr,
          color: MYColor.success,
          icon: CupertinoIcons.info_circle,
        );

        return res.body['code'];
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
