import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/response/the_response.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../complaints_model.dart';

class ComplaintsProvider extends GetConnect {
  final box = GetStorage();

  Future<Complaints> getComplaints() async {
    await EasyLoading.show(status: 'waiting'.tr);
    try {
      final res = await get(
        "${Constance.apiEndpoint}/complaints",
        headers: {"Authorization": "Bearer ${Constance.instance.token}"},
      );

      await EasyLoading.dismiss();

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Complaints.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  Future<int> postComplaints(FormData formData) async {
    await EasyLoading.show(status: 'loading'.tr);
    try {
      final res = await post(
        "${Constance.apiEndpoint}/create_complaints",
        formData,
        headers: {"Authorization": "Bearer ${Constance.instance.token}"},
      );

      await EasyLoading.dismiss();

      if (res.body['code'] == 0) {
        if (res.body['data']['name'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال الاسم",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['description'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال الوصف",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['type'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال نوع الشكوى",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['importance'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال اهمية الشكوى",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['file'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال الملف",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
        if (res.body['data']['contract_id'] != null) {
          mySnackBar(
            title: "عفوا",
            message: "الرجاء ادخال رقم العقد",
            color: MYColor.warning,
            icon: CupertinoIcons.info_circle,
          );
        }
      }

      if (res.body['code'] == 1) {
        mySnackBar(
          title: "تم",
          message: "تم ارسال الشكوى بنجاح",
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

  Future<TheResponse<Complaints>> fetchComplaints() async {
    await EasyLoading.show(status: 'waiting'.tr);
    try {
      final res = await get(
        "${Constance.apiEndpoint}/complaints",
        headers: {"Authorization": "Bearer ${Constance.instance.token}"},
      );
      await EasyLoading.dismiss();
      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return TheResponse.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
