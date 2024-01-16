import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/delegation/delegations_model.dart';
import 'package:musaneda/app/modules/delegation/providers/delegations_provider.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../data/iqama_validator.dart';

class DelegationController extends GetxController {
  static DelegationController get I => Get.put(DelegationController());

  @override
  void onInit() {
    super.onInit();
    getDelegations();
  }

  RxBool isLoading = false.obs;
  final formDelegationKey = GlobalKey<FormState>();
  var nationalityID = 0.obs;
  set setNationalityID(value) {
    nationalityID.value = value;
    update();
  }

  var listDelegations = List<DelegationsData>.empty(growable: true).obs;

  TextEditingController txtFullName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtIqama = TextEditingController();

  void fillData(DelegationsData delegationsData) {
    txtFullName.text = delegationsData.name!;
    txtPhone.text = delegationsData.phone!;
    txtIqama.text = delegationsData.iqama!;
  }

  void clearData() {
    txtFullName.clear();
    txtPhone.clear();
    txtIqama.clear();
  }

  validateFullName(String value) {
    if (value.isEmpty) {
      return "msg_plz_enter_full_name".tr;
    } else if (value.length < 6) {
      return "msg_plz_name_should_be_more_than_6_char".tr;
    }
    return null;
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

  validateIqama(String value) {
    if (value.isEmpty) {
      return "msg_plz_enter_iqama_number".tr;
    } else if (IqamaValidator.validate(value) == false) {
      return "msg_plz_enter_correct_iqama_number".tr;
    }
    return null;
  }

  void createDelegation() {
    if (formDelegationKey.currentState!.validate()) {
      if (nationalityID.value != 0) {
        Map body = {
          'name': txtFullName.text,
          'phone': txtPhone.text,
          'iqama': txtIqama.text,
          'nationality_id': nationalityID.value,
          'status': 2,
        };

        DelegationsProvider().postDelegation(body).then((value) {
          if (value) {
            getDelegations();
            Get.back();
          }
        });
      } else {
        mySnackBar(
          title: "select_nationality".tr,
          message: "msg_plz_select_nationality".tr,
          color: MYColor.warning,
          icon: CupertinoIcons.info,
        );
      }
    }
    update();
  }

  void updateDelegation(id) {
    if (formDelegationKey.currentState!.validate()) {
      if (nationalityID.value != 0) {
        Map body = {
          'name': txtFullName.text,
          'phone': txtPhone.text,
          'iqama': txtIqama.text,
          'nationality_id': nationalityID.value,
          'status': 2,
        };
        DelegationsProvider().updateDelegation(body, id).then((value) {
          if (value) {
            getDelegations();
            Get.back();
          }
        });
      } else {
        mySnackBar(
          title: "select_nationality".tr,
          message: "msg_plz_select_nationality".tr,
          color: MYColor.warning,
          icon: CupertinoIcons.info,
        );
      }
    }
    update();
  }

  Future<void> getDelegations() async {
    isLoading(true);
    DelegationsProvider().getDelegations().then((value) {
      listDelegations.clear();
      for (var data in value.data as List) {
        listDelegations.add(data);
      }
      isLoading(false);
    });

    update();
  }

  Future<void> deleteDelegation(DelegationsData delegation) async {
    DelegationsProvider().deleteDelegation(delegation.id!).then((value) {
      if (value) {
        listDelegations
            .where((p) => p.id == delegation.id)
            .toList()
            .forEach((element) {
          listDelegations.remove(element);
        });
      }
    });
    update();
  }

  Future<void> statusDelegation(DelegationsData delegation, status) async {
    DelegationsProvider()
        .statusDelegation(delegation.id!, status)
        .then((value) {
      if (value) {
        listDelegations
            .where((p) => p.id == delegation.id)
            .toList()
            .forEach((element) {
          element.status = status;
        });
      }
    });
    update();
  }
}
