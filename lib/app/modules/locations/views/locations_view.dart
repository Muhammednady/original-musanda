import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../components/myWarningDialog.dart';
import '../../../../config/myColor.dart';
import '../controllers/locations_controller.dart';
import 'create_location_view.dart';

class LocationsView extends GetView<LocationsController> {
  const LocationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('location'.tr),
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
                  "location".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'montserrat_medium',
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => const CreateLocationView(
                        action: 'create',
                        page: 'location',
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
                        "add_location".tr,
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
            child: GetX(
              init: controller,
              builder: (ctx) {
                if (controller.listLocations.isEmpty) {
                  return Center(
                    child: Text(
                      "you_have_no_locations_yet".tr,
                      style: TextStyle(
                        color: MYColor.black,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.listLocations.length,
                  itemBuilder: (ctx, i) {
                    var obj = controller.listLocations[i];
                    return Container(
                      height: 138,
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
                                  obj.address!.length > 30
                                      ? '${obj.address!.substring(0, 25)}...'
                                      : obj.address!,
                                  style: TextStyle(
                                    color: MYColor.black,
                                    fontSize: 14,
                                    fontFamily: 'montserrat_regular',
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => const CreateLocationView(
                                        action: 'update',
                                        page: 'location',
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
                                      title: 'delete_location'.tr,
                                      content:
                                          'do_you_want_to_delete_location'.tr,
                                      cancel: 'cancel'.tr,
                                      confirm: 'confirm'.tr,
                                      funConfirm: () =>
                                          controller.deleteLocations(obj.id),
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
                                      "country".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      obj.country!.length > 10
                                          ? '${obj.country!.substring(0, 10)}...'
                                          : obj.country!,
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
                                      "city".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      obj.city!,
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
                                      "details".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      obj.notes!.length > 10
                                          ? '${obj.notes!.substring(0, 10)}...'
                                          : "${obj.notes}",
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
