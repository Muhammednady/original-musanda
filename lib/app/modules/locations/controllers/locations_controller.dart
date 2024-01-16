import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musaneda/app/modules/locations/locations_model.dart';
import 'package:musaneda/app/modules/locations/providers/locations_provider.dart';
import 'package:musaneda/app/modules/order/controllers/order_controller.dart';
import 'package:musaneda/app/modules/order/views/selected_package_view.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/constance.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../components/myCupertinoButton.dart';

class LocationsController extends GetxController {
  static LocationsController get I => Get.put(LocationsController());
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtNotes = TextEditingController();
  var isLoading = false.obs;

  var isMoving = true.obs;
  set isCameraMoving(move) {
    isMoving.value = move;
    update();
  }

  @override
  void onInit() {
    getLocations();
    determinePosition();
    getCurrentLocation();
    super.onInit();
  }

  final Completer<GoogleMapController> gMC = Completer();

  var initZoom = 14.4746;
  var initCoordinates = const LatLng(24.681226, 46.7381333);

  LatLng? myLocation;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    var position = await determinePosition();
    final GoogleMapController controller = await gMC.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: initZoom,
        ),
      ),
    );
    update();
  }

  var address = ''.obs;
  var subLocality = ''.obs;
  var formattedAddress = ''.obs;
  var city = ''.obs;
  var country = ''.obs;
  var latitude = ''.obs;
  var longitude = ''.obs;
  var countryCode = ''.obs;
  final box = GetStorage();

  void getAddress(LatLng position) async {
    final coordinates = await locationFromAddress(
      '${position.latitude}, ${position.longitude}',
    );

    List<Placemark> addresses = await placemarkFromCoordinates(
      coordinates.first.latitude,
      coordinates.first.longitude,
    );

    Placemark first = addresses.first;

    Pretty.instance.logger.d(first.toJson());

    Map location = {
      'address': first.street,
      'formattedAddress': '${first.name}, ${first.street}',
      'city': first.locality,
      'country': first.country,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'countryCode': first.isoCountryCode,
      'postalCode': first.postalCode,
      'subAdminArea': first.subAdministrativeArea,
      'subLocality': first.subLocality,
      'subThoroughfare': first.subThoroughfare,
      'thoroughfare': first.thoroughfare,
      'adminArea': first.administrativeArea,
      'featureName': first.name,
      'hashCode': first.hashCode,
    };
    log(location.toString(), name: 'location');

    box.write('my_location_objects', location);
    box.write('countryCode', first.isoCountryCode);

    address.value = first.street!;
    subLocality.value = first.subLocality!;
    formattedAddress.value = '${first.name}, ${first.street}';
    city.value = first.locality!;
    country.value = first.country!;
    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();
    countryCode.value = first.isoCountryCode!;

    update();
  }

  void saveLocation(context, page) {
    if (countryCode.value != 'SA') {
      mySnackBar(
        message: 'msg_excuse_location_out_of_country'.tr,
        color: MYColor.warning,
        title: 'warning'.tr,
        icon: Icons.warning,
      );
      return;
    }
    getAddress(myLocation!);
    showExtraDetailsDialog(context, page);

    OrderController.I.setLocationForPayment = address.value;
    update();
  }

  final formExtraKey = GlobalKey<FormState>();

  void showExtraDetailsDialog(context, page) {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: const BoxConstraints(
        // maxHeight: 370,
        maxWidth: double.infinity,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formExtraKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                  subLocality.value,
                  style: TextStyle(
                    color: MYColor.greyDeep,
                    fontSize: 12,
                    height: 2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  address.value,
                  style: TextStyle(
                    color: MYColor.greyDeep,
                    fontSize: 12,
                    height: 2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "other_details".tr,
                  style: TextStyle(
                    color: MYColor.primary,
                    fontFamily: 'montserrat_medium',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                _titleTextField(context),
                const SizedBox(height: 15),
                _notesTextField(context),
                const SizedBox(height: 10),
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: MyCupertinoButton(
                    btnColor: MYColor.buttons,
                    txtColor: MYColor.white,
                    text: "add_location".tr,
                    fun: () {
                      if (formExtraKey.currentState!.validate()) {
                        postLocations();
                        log('main_home_page', name: 'main_home_page');
                        Get.back();
                        Get.back();

                        if (page == 'main_home_page') {
                          Get.to(() => const SelectedPackageView());
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  /// title text field
  TextFormField _titleTextField(BuildContext context) {
    return TextFormField(
      controller: txtTitle,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      validator: (value) {
        if (value!.isEmpty) {
          return 'please_enter_title'.tr;
        }
        return null;
      },
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        labelText: "location_name".tr,
        labelStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        hintText: "location_address_text".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 12,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }

  /// notes text field
  TextFormField _notesTextField(BuildContext context) {
    return TextFormField(
      controller: txtNotes,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      validator: (value) {
        if (value!.isEmpty) {
          return 'please_enter_notes'.tr;
        }
        return null;
      },
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        labelText: "other_details".tr,
        hintText: "other_details_text".tr,
        labelStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 12,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }

  var listLocations = List<LocationsData>.empty(growable: true).obs;

  Future<void> getLocations() async {
    isLoading(true);
    LocationsProvider().getLocations().then((value) {
      listLocations.clear();
      for (var data in value.data as List) {
        listLocations.add(data);
      }
      isLoading(false);
    });

    update();
  }

  void postLocations() {
    Map data = {
      "address": address.value,
      "city": city.value,
      "country": country.value,
      "latitude": latitude.value,
      "longitude": longitude.value,
      "title": txtTitle.text,
      "notes": txtNotes.text,
    };
    LocationsProvider().postLocations(data).then((value) {
      if (value == 1) {
        getLocations();
        OrderController.I.getLocations();
        Get.back();
      }
    });
    update();
  }

  void deleteLocations(id) {
    Get.back();
    LocationsProvider().deleteLocations(id).then((value) {
      if (value == 1) {
        getLocations();
        Get.back();
      }
    });
    update();
  }

  void onCameraIdle() {
    getAddress(myLocation!);
    isCameraMoving = false;
    update();
  }
}
