// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyCupertinoButton extends StatelessWidget {
  final Function fun;
  final String text;
  final Color btnColor;
  final Color txtColor;

  const MyCupertinoButton({
    super.key,
    required this.fun,
    required this.text,
    required this.btnColor,
    required this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 45,
      onPressed: () => fun(),
      color: btnColor,
      borderRadius: BorderRadius.circular(10),
      child: Text(
        text.tr,
        style: TextStyle(
          fontFamily: 'montserrat_regular',
          fontSize: 14,
          color: txtColor,
        ),
      ),
    );
  }
}
