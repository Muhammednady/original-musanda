// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget myInkWell(
    {required Function fun,
    required String text,
    required double? size,
    required String font,
    required Color color}) {
  return InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: () => fun(),
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Text(
        text.tr,
        style: TextStyle(
          color: color,
          fontSize: size,
          decoration: TextDecoration.underline,
          fontFamily: font,
        ),
      ),
    ),
  );
}
