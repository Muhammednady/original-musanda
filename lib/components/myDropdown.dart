// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musaneda/config/myColor.dart';

Widget myDropdown({context, value, required onChanged, required items}) {
  return Container(
    height: 50,
    margin: const EdgeInsets.only(top: 5),
    padding: const EdgeInsets.only(
      top: 4,
      left: 16,
      right: 16,
      bottom: 4,
    ),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(4),
      ),
      color: MYColor.white,
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        dropdownColor: MYColor.white,
        value: value,
        onChanged: onChanged,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        menuMaxHeight: MediaQuery.of(context).size.height / 3,
        icon: Icon(
          CupertinoIcons.chevron_down,
          size: 15,
          color: MYColor.buttons,
        ),
        isExpanded: true,
        items: items,
      ),
    ),
  );
}
