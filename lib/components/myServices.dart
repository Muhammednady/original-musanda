// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../config/myColor.dart';

class MyServices extends StatelessWidget {
  final double left;
  final double right;

  const MyServices({super.key, required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 97,
      width: double.infinity,
      padding: EdgeInsets.only(left: left, right: right),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: SvgPicture.asset(
                  "assets/images/services/cleaning_with_background.svg",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'cleaning'.tr,
                style: TextStyle(
                  color: MYColor.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: SvgPicture.asset(
                  "assets/images/services/washing _with_background.svg",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'washing'.tr,
                style: TextStyle(
                  color: MYColor.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: SvgPicture.asset(
                  "assets/images/services/cooking_with_background.svg",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'cooking'.tr,
                style: TextStyle(
                  color: MYColor.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: SvgPicture.asset(
                  "assets/images/services/child_care_with_background.svg",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'baby_sitting'.tr,
                style: TextStyle(
                  color: MYColor.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
