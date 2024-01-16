import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';

import '../../../../components/myContractDetailsCard.dart';
import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myWarningDialog.dart';
import '../../../../config/myColor.dart';
import '../controllers/contract_controller.dart';

class ContractView extends GetView<ContractController> {
  const ContractView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('contract_details'.tr),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: controller,
        builder: (ctx) => Stack(
          children: [
            Stack(
              children: [
                Container(
                  height: 40,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: MYColor.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: MyContractDetailsCard(
                      title: "musaneda_details".tr,
                      subtitle: "",
                      name: "full_name".tr,
                      nameValue: LanguageController.I.getLocale == 'en'
                          ? Get.arguments.musaneda.name.en
                          : Get.arguments.musaneda.name.ar,
                      label: "education".tr,
                      labelValue: LanguageController.I.getLocale == 'en'
                          ? Get.arguments.musaneda.education.name.en
                          : Get.arguments.musaneda.education.name.ar,
                      lastLabel: "country".tr,
                      lastLabelValue: LanguageController.I.getLocale == 'en'
                          ? Get.arguments.musaneda.nationality.name.en
                          : Get.arguments.musaneda.nationality.name.ar,
                    ),
                  ),
                  const SizedBox(height: 15),
                  MyContractDetailsCard(
                    title: "client_details".tr,
                    subtitle: "",
                    name: "full_name".tr,
                    nameValue: Get.arguments.user.name,
                    label: "phone_number".tr,
                    labelValue: Get.arguments.user.phone,
                    lastLabel: "duration".tr,
                    lastLabelValue:
                        "${Get.arguments.package.duration.toString()} ${"month".tr}",
                  ),
                  const SizedBox(height: 15),
                  MyContractDetailsCard(
                    title: "price".tr,
                    subtitle:
                        "${Get.arguments.package.price.toString()} ${"sar".tr}",
                    name: "total".tr,
                    nameValue:
                        "${Get.arguments.package.total.toString()} ${"sar".tr}",
                    label: "discount".tr,
                    labelValue: "${Get.arguments.package.discount.toString()}%",
                    lastLabel: "tax".tr,
                    lastLabelValue: "${Get.arguments.package.tax.toString()}%",
                  ),
                  const SizedBox(height: 15),
                  Get.arguments.status == 'pending'
                      ? const SizedBox()
                      : Get.arguments.status == 'canceled'
                          ? const SizedBox()
                          : Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: MYColor.warning.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.info_circle,
                                    color: MYColor.warning,
                                    size: 26,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "if_the_contract_is_cancelled".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.justify,
                                      strutStyle: const StrutStyle(
                                        height: 1.8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  const SizedBox(height: 20),
                  Get.arguments.status == 'pending'
                      ? const SizedBox()
                      : Get.arguments.status == 'canceled'
                          ? const SizedBox()
                          : SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: MyCupertinoButton(
                                btnColor: Get.arguments.status == "active"
                                    ? MYColor.accent
                                    : MYColor.buttons,
                                txtColor: Get.arguments.status == "active"
                                    ? MYColor.black
                                    : MYColor.white,
                                text: Get.arguments.status == "active"
                                    ? "cancel_the_contract".tr
                                    : "contract_renewal".tr,
                                fun: () {
                                  int musanedaId = Get.arguments.musaneda.id;
                                  if (Get.arguments.status == "active") {
                                    myWarningDialog(
                                      title: "cancel_the_contract".tr,
                                      content:
                                          "if_the_contract_is_cancelled".tr,
                                      cancel: "cancel".tr,
                                      confirm: "confirm".tr,
                                      funConfirm: () =>
                                          controller.cancelContract(
                                        musanedaId,
                                      ),
                                      funWillPop: () {
                                        Get.back();
                                      },
                                      funCancel: () {
                                        Get.back();
                                      },
                                    );
                                  } else {
                                    controller.renewContract(musanedaId);
                                  }
                                },
                              ),
                            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
