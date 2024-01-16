// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/config/myColor.dart';

mySnackBar({
  required String title,
  required String message,
  required Color color,
  required IconData icon,
}) =>
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
      colorText: MYColor.white,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 100),
      borderRadius: 8,
      animationDuration: const Duration(milliseconds: 1000),
      duration: const Duration(milliseconds: 1000),
      icon: Icon(icon, color: MYColor.white),
      leftBarIndicatorColor: MYColor.primary,
      shouldIconPulse: true,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
      reverseAnimationCurve: Curves.fastOutSlowIn,
    );
