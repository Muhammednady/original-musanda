import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/components/myWarningDialog.dart';

import '../../../../config/myColor.dart';
import '../controllers/delegation_controller.dart';
import 'create_delegation_view.dart';

class DelegationView extends GetView<DelegationController> {
  const DelegationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('delegate_client'.tr),
        centerTitle: true,
      ),
      body: Stack(
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
            padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "delegation".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'montserrat_medium',
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    controller.clearData();
                    Get.to(
                      () => const CreateDelegationView(
                        action: 'create',
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/icon/plus.svg',
                        height: 20.31,
                        width: 19.5,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "add_delegation".tr,
                        style: TextStyle(
                          fontSize: 12,
                          color: MYColor.buttons,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Obx(
              () {
                return ListView.builder(
                  itemCount: controller.listDelegations.length,
                  itemBuilder: (ctx, i) {
                    return Container(
                      height: 184,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: MYColor.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  controller.listDelegations[i].name!,
                                  style: TextStyle(
                                    color: MYColor.black,
                                    fontSize: 14,
                                    fontFamily: 'montserrat_regular',
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    controller.fillData(
                                      controller.listDelegations[i],
                                    );
                                    Get.to(
                                      () => CreateDelegationView(
                                        action: 'update',
                                        delegations:
                                            controller.listDelegations[i],
                                      ),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/icon/pencil.svg",
                                    width: 17.88,
                                    height: 17.88,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                InkWell(
                                  onTap: () {
                                    myWarningDialog(
                                      title: 'delete_delegation'.tr,
                                      content: 'delete_delegation_content'.tr,
                                      cancel: 'cancel'.tr,
                                      confirm: 'confirm'.tr,
                                      funConfirm: () {
                                        controller
                                            .deleteDelegation(
                                              controller.listDelegations[i],
                                            )
                                            .then(
                                              (value) => Get.back(),
                                            );
                                      },
                                      funWillPop: () {
                                        Get.back();
                                      },
                                      funCancel: () {
                                        Get.back();
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/icon/remove.svg",
                                    width: 17.88,
                                    height: 17.88,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: MYColor.buttons,
                            thickness: 0.1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "iqama_number".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      controller.listDelegations[i].iqama!,
                                      style: TextStyle(
                                        color: MYColor.buttons,
                                        fontSize: 14,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "country".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      controller.listDelegations[i].nationality!
                                          .name!.ar!,
                                      style: TextStyle(
                                        color: MYColor.buttons,
                                        fontSize: 14,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "phone_number".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      controller.listDelegations[i].phone!,
                                      style: TextStyle(
                                        color: MYColor.buttons,
                                        fontSize: 14,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 40,
                            width: 308,
                            child: GetBuilder(
                              init: controller,
                              builder: (ctx) {
                                return MyCupertinoButton(
                                  fun: () {
                                    if (controller.listDelegations[i].status ==
                                        2) {
                                      controller.statusDelegation(
                                        controller.listDelegations[i],
                                        1,
                                      );
                                    } else {
                                      controller.statusDelegation(
                                        controller.listDelegations[i],
                                        2,
                                      );
                                    }
                                  },
                                  text:
                                      controller.listDelegations[i].status == 2
                                          ? "delegate".tr
                                          : "cancel_delegation".tr,
                                  btnColor:
                                      controller.listDelegations[i].status == 2
                                          ? MYColor.success
                                          : MYColor.buttons,
                                  txtColor: MYColor.white,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
