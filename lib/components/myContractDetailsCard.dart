// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../config/myColor.dart';

class MyContractDetailsCard extends StatelessWidget {
  final String title;
  final String subtitle;

  final String label;
  final String labelValue;

  final String name;
  final String nameValue;

  final String lastLabel;
  final String lastLabelValue;

  const MyContractDetailsCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.label,
      required this.labelValue,
      required this.name,
      required this.nameValue,
      required this.lastLabel,
      required this.lastLabelValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MYColor.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
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
                  title,
                  style: TextStyle(
                    color: MYColor.black,
                    fontSize: 14,
                    fontFamily: 'montserrat_regular',
                  ),
                ),
                const Spacer(),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: MYColor.buttons,
                    fontSize: 15,
                    fontFamily: 'montserrat_regular',
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
                      name,
                      style: TextStyle(
                        color: MYColor.black,
                        fontSize: 12,
                        fontFamily: 'montserrat_regular',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      nameValue.substring(
                          0, nameValue.length > 10 ? 10 : nameValue.length),
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
                      label,
                      style: TextStyle(
                        color: MYColor.black,
                        fontSize: 12,
                        fontFamily: 'montserrat_regular',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      labelValue,
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
                      lastLabel,
                      style: TextStyle(
                        color: MYColor.black,
                        fontSize: 12,
                        fontFamily: 'montserrat_regular',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      lastLabelValue,
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
          )
        ],
      ),
    );
  }
}
