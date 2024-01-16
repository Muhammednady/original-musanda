import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/custom_payment/controllers/custom_payment_controller.dart';
import 'package:musaneda/app/modules/main_home_page/contract_model.dart';
import 'package:musaneda/app/modules/main_home_page/controllers/main_home_page_controller.dart';
import 'package:musaneda/app/modules/main_home_page/views/payments_view.dart';
import 'package:musaneda/app/modules/profile/controllers/profile_controller.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/components/myWarningDialog.dart';

import '../../../../config/myColor.dart';

class ContractDetailsView extends GetView<MainHomePageController> {
  final ContractData contractModel;
  final bool isPaid;

  const ContractDetailsView(
      {Key? key, required this.isPaid, required this.contractModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MYColor.primary,
        iconTheme: IconThemeData(
          color: MYColor.buttons,
          size: 20,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          'contract_details'.tr,
          style: TextStyle(
            color: MYColor.buttons,
          ),
        ),
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) => ListView(
          children: [
            Container(
              height: 143,
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
                          'contract_details'.tr,
                          style: TextStyle(
                            color: MYColor.black,
                            fontSize: 14,
                            fontFamily: 'montserrat_regular',
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 29,
                            width: 90,
                            decoration: BoxDecoration(
                              color: isPaid
                                  ? MYColor.success.withOpacity(0.1)
                                  : MYColor.warning.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                isPaid ? 'paid'.tr : 'unpaid'.tr,
                                style: TextStyle(
                                  color: isPaid
                                      ? MYColor.success
                                      : MYColor.warning,
                                  fontSize: 12,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Visibility(
                          visible: isPaid,
                          child: InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "assets/images/icon/contract.svg",
                              width: 18.75,
                              height: 25,
                            ),
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
                              "start_date".tr,
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 12,
                                fontFamily: 'montserrat_regular',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              contractModel.startDate!,
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
                              "expiry_date".tr,
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 12,
                                fontFamily: 'montserrat_regular',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              contractModel.endDate!,
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
                              "contract_number".tr,
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 12,
                                fontFamily: 'montserrat_regular',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              contractModel.number!.substring(0, 10),
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
                  )
                ],
              ),
            ),
            Container(
              height: 143,
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
                          'package_details'.tr,
                          style: TextStyle(
                            color: MYColor.black,
                            fontSize: 14,
                            fontFamily: 'montserrat_regular',
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
                              "duration".tr,
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 12,
                                fontFamily: 'montserrat_regular',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${contractModel.duration!.duration} ${'month'.tr}',
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
                              "price".tr,
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 12,
                                fontFamily: 'montserrat_regular',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${contractModel.price} ${"sar".tr}',
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
                              "service".tr,
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 12,
                                fontFamily: 'montserrat_regular',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${contractModel.service!.name}",
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
                  )
                ],
              ),
            ),
            Container(
              height: 200,
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
                          'client_details'.tr,
                          style: TextStyle(
                            color: MYColor.black,
                            fontSize: 14,
                            fontFamily: 'montserrat_regular',
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "client_name".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${ProfileController.I.getProfileData.name}',
                                    style: TextStyle(
                                      color: MYColor.buttons,
                                      fontSize: 14,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    '${ProfileController.I.getProfileData.phone}',
                                    style: TextStyle(
                                      color: MYColor.buttons,
                                      fontSize: 14,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "email".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${ProfileController.I.getProfileData.email}',
                                    style: TextStyle(
                                      color: MYColor.buttons,
                                      fontSize: 14,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    '${ProfileController.I.getProfileData.iqama}',
                                    style: TextStyle(
                                      color: MYColor.buttons,
                                      fontSize: 14,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: Get.width / 2.2,
                    child: Visibility(
                      visible: !isPaid,
                      child: MyCupertinoButton(
                        text: 'cancel'.tr,
                        fun: () {
                          myWarningDialog(
                            title: 'cancel'.tr,
                            content: 'cancel_order_content'.tr,
                            cancel: 'cancel'.tr,
                            confirm: 'confirm'.tr,
                            funConfirm: () {
                              Get.back();
                              Get.back();
                              controller.cancelOrder(contractModel.id!);
                            },
                            funWillPop: () {
                              Get.back();
                            },
                            funCancel: () {
                              Get.back();
                            },
                          );
                        },
                        btnColor: MYColor.warning,
                        txtColor: MYColor.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 2.2,
                    child: Visibility(
                      visible: !isPaid,
                      child: MyCupertinoButton(
                        text: 'payment'.tr,
                        fun: () {
                          controller.setServiceModel = contractModel.service!;
                          controller.setSelectedService =
                              contractModel.service!;
                          controller.setSelectedDuration =
                              contractModel.duration!.duration!;
                          CustomPaymentController.I.setIsPayOrder = true;
                          CustomPaymentController.I.setContractModel =
                              contractModel;
                          Get.to(
                            () => const PaymentsView(
                              isFake: true,
                            ),
                          );
                        },
                        btnColor: MYColor.buttons,
                        txtColor: MYColor.white,
                      ),
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
