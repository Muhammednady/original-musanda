import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/main_home_page/views/payments_view.dart';
import 'package:musaneda/app/modules/order/controllers/order_controller.dart';
import 'package:musaneda/config/myColor.dart';

import '../../main_home_page/controllers/main_home_page_controller.dart';

class SelectedPackageView extends GetView<MainHomePageController> {
  const SelectedPackageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    return GetBuilder(
      init: controller,
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: MYColor.transparent,
          title: Text('contract_duration'.tr),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'select_duration'.tr,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: GetBuilder(
                  init: controller,
                  builder: (_) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.durations.length,
                    itemBuilder: (ctx, i) {
                      return InkWell(
                        onTap: () {
                          controller.setSelectedDuration =
                              controller.durations[i].duration!;
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: Get.width / 4.3,
                          height: 25,
                          decoration: BoxDecoration(
                            color: controller.getDuration ==
                                    controller.durations[i].duration
                                ? MYColor.primary
                                : MYColor.secondary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "${controller.durations[i].duration} ${'month'.tr}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'select_date'.tr,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              GetBuilder(
                init: controller,
                builder: (_) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Days from 1 to 31
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: Get.width / 3.5,
                          child: Container(
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
                            child: GetBuilder(
                              init: controller,
                              builder: (_) {
                                return CupertinoPicker(
                                  itemExtent: 30,
                                  onSelectedItemChanged: (value) {
                                    controller.selectedDay =
                                        value + DateTime.now().day;
                                  },
                                  children: List.generate(
                                    controller.generateDays(),
                                    (index) => Text(
                                      controller.getMonth ==
                                              DateTime.now().month
                                          ? '${index + DateTime.now().day}'
                                          : '${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'day'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    // Months from 1 to 12
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: Get.width / 3.5,
                          child: Container(
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
                            child: GetBuilder(
                              init: controller,
                              builder: (_) {
                                return CupertinoPicker(
                                  itemExtent: 30,
                                  onSelectedItemChanged: (value) {
                                    controller.selectedMonth =
                                        value + DateTime.now().month;
                                  },
                                  children: List.generate(
                                    12,
                                    (index) => Text(
                                      '${index + DateTime.now().month}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'month'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    // Years from 2021 to 2030
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: Get.width / 3.5,
                          child: Container(
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
                            child: CupertinoPicker(
                              itemExtent: 30,
                              onSelectedItemChanged: (value) {
                                controller.selectedYear = value;
                              },
                              children: List.generate(
                                1,
                                (index) => Text(
                                  '${index + DateTime.now().year}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'year'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: Get.width,
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
                      child: Image.asset(
                        "${controller.getServiceModel.packages!.first.image}",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: Text(
                            "service".tr,
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 1.7,
                          child: Text(
                            "( ${controller.getServiceModel.name} ) ${controller.getServiceModel.packages!.first.name}",
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 14,
                            ),
                            // textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: Text(
                            "package_price".tr,
                            style: TextStyle(
                              color: MYColor.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 1.7,
                          child: Text(
                            "${controller.getServiceModel.packages!.first.price} ${"sar".tr}",
                            style: TextStyle(
                              color: MYColor.grey,
                              fontSize: 14,
                            ),
                            textAlign: LanguageController.I.getLocale == 'ar'
                                ? TextAlign.end
                                : TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: Text(
                            "duration".tr,
                            style: TextStyle(
                              color: MYColor.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 1.7,
                          child: Text(
                            "${controller.getDuration} ${"month".tr}",
                            style: TextStyle(
                              color: MYColor.grey,
                              fontSize: 14,
                            ),
                            textAlign: LanguageController.I.getLocale == 'ar'
                                ? TextAlign.end
                                : TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: controller.finalDiscount != 0,
                      child: const Divider(),
                    ),
                    Visibility(
                      visible: controller.finalDiscount != 0,
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "price_before_discount".tr,
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.7,
                            child: Text(
                              "${controller.beforeDiscount} ${"sar".tr}",
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                              textAlign: LanguageController.I.getLocale == 'ar'
                                  ? TextAlign.end
                                  : TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.finalDiscount != 0,
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "discount".tr,
                              style: TextStyle(
                                color: MYColor.success,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.7,
                            child: Text(
                              "${controller.finalDiscount} ${"sar".tr}",
                              style: TextStyle(
                                color: MYColor.success,
                                fontSize: 14,
                              ),
                              textAlign: LanguageController.I.getLocale == 'ar'
                                  ? TextAlign.end
                                  : TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.finalDiscount != 0,
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "price_after_discount".tr,
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.7,
                            child: Text(
                              "${controller.finalPrice} ${"sar".tr}",
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                              textAlign: LanguageController.I.getLocale == 'ar'
                                  ? TextAlign.end
                                  : TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          height: 30,
                          child: Text(
                            "final_price".tr,
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 1.7,
                          height: 30,
                          child: Text(
                            "${controller.finalPrice} ${"sar".tr}",
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: LanguageController.I.getLocale == 'ar'
                                ? TextAlign.end
                                : TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: Get.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // controller.payment();
                    Get.to(
                      () => const PaymentsView(
                        isFake: false,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'confirm'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
