// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musaneda/app/modules/locations/controllers/locations_controller.dart';
import 'package:musaneda/components/myCupertinoButton.dart';

import '../../../../config/myColor.dart';

class CreateLocationView extends GetView<LocationsController> {
  final String action;
  final String page;

  const CreateLocationView({
    super.key,
    required this.action,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: LocationsController.I,
        builder: (ctx) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.initCoordinates,
                  zoom: controller.initZoom,
                ),
                onMapCreated: (GoogleMapController ctl) {
                  controller.gMC.complete(ctl);
                },
                onCameraMove: (CameraPosition position) {
                  controller.myLocation = position.target;
                  controller.isCameraMoving = true;
                },
                onCameraIdle: () async {
                  controller.onCameraIdle();
                },
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                padding: const EdgeInsets.all(0),
                buildingsEnabled: true,
                cameraTargetBounds: CameraTargetBounds.unbounded,
                compassEnabled: true,
                indoorViewEnabled: true,
                mapToolbarEnabled: true,
                minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
              ),
              Positioned(
                bottom: Get.height / 2,
                right: 0,
                left: 0,
                child: Icon(
                  CupertinoIcons.location_solid,
                  size: 50,
                  color: MYColor.buttons,
                ),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset(
                    "assets/images/icon/back.svg",
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              Positioned(
                top: Get.height / 2,
                right: 20,
                child: Card(
                  elevation: 4,
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: () => controller.getCurrentLocation(),
                    splashRadius: 25,
                    icon: SvgPicture.asset(
                      "assets/images/icon/current_location.svg",
                      width: 30,
                      height: 30,
                      color: MYColor.buttons,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Visibility(
                      visible: !controller.isMoving.value,
                      child: Container(
                        height:
                            controller.address.value.length > 60 ? 130 : 100,
                        width: Get.width,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: MYColor.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "delivery_location".tr,
                                style: TextStyle(
                                  color: MYColor.buttons,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                controller.subLocality.value,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 12,
                                  height: 2,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: Text(
                                  controller.address.value,
                                  style: TextStyle(
                                    color: MYColor.greyDeep,
                                    fontSize: 12,
                                    height: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 52,
                      width: Get.width,
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: MyCupertinoButton(
                        fun: () => controller.saveLocation(
                          context,
                          page,
                        ),
                        text: "select_location".tr,
                        btnColor: MYColor.buttons,
                        txtColor: MYColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
