import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/api_response.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../contract_model.dart';

class MainHomePageProvider extends GetConnect {
  Future<Contract> getContractList() async {
    final response = await get(
      '${Constance.apiEndpoint}/fetch_orders',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Constance.instance.token}",
      },
    );

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return Contract.fromJson(response.body);
    }
  }

  Future<ApiResponse> postContractList(Map data) async {
    final response = await post(
      '${Constance.apiEndpoint}/create_order',
      data,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Constance.instance.token}",
      },
    );

    log(response.body.toString(), name: 'post contract list');

    if (response.body['code'] == 0) {
      mySnackBar(
        title: "error".tr,
        message: "msg_order_already_exist".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    }

    if (response.body['code'] == 1) {
      mySnackBar(
        title: "success".tr,
        message: "msg_order_successfully_done".tr,
        color: MYColor.success,
        icon: CupertinoIcons.check_mark_circled,
      );
    }

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return ApiResponse.fromJson(response.body);
    }
  }

  Future<ApiResponse> cancelContractList(id) async {
    final response = await get(
      '${Constance.apiEndpoint}/cancel_order/$id',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Constance.instance.token}",
      },
    );

    if (response.body['code'] == 1) {
      mySnackBar(
        title: 'order_cancelled'.tr,
        message: 'order_cancelled_successfully'.tr,
        color: MYColor.success,
        icon: CupertinoIcons.check_mark_circled,
      );
    }

    if (response.body['code'] == 0) {
      mySnackBar(
        title: 'error'.tr,
        message: 'msg_order_already_cancelled'.tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    }

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return ApiResponse.fromJson(response.body);
    }
  }

  Future<ApiResponse> payOrder(Map data) async {
    final response = await post(
      '${Constance.apiEndpoint}/pay_order',
      data,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Constance.instance.token}",
      },
    );

    if (response.body['code'] == 0) {
      mySnackBar(
        title: "error".tr,
        message: "order_unpaid_successfully".tr,
        color: MYColor.warning,
        icon: CupertinoIcons.info_circle,
      );
    }

    if (response.body['code'] == 1) {
      mySnackBar(
        title: "success".tr,
        message: "order_paid_successfully".tr,
        color: MYColor.success,
        icon: CupertinoIcons.check_mark_circled,
      );
    }

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return ApiResponse.fromJson(response.body);
    }
  }
}
