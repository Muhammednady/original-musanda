// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSize myPreferredSize({required String title}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(250),
    child: Container(
      height: 203,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
        image: DecorationImage(
          image: AssetImage("assets/images/png/login_register_forget_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 40,
            child: Text(
              title.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontFamily: 'montserrat_semi_bold',
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
