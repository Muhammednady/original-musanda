// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/myColor.dart';

class MyComplaintCard extends StatelessWidget {
  final String title;
  final String status;
  final String contractID;
  final String type;
  final String date;
  final String description;

  const MyComplaintCard(
      {super.key,
      required this.title,
      required this.status,
      required this.contractID,
      required this.type,
      required this.date,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
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
                  title,
                  style: TextStyle(
                    color: MYColor.black,
                    fontSize: 14,
                    fontFamily: 'montserrat_regular',
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 29,
                    width: 53.94,
                    decoration: BoxDecoration(
                      color: status == "closed"
                          ? MYColor.buttons.withOpacity(0.1)
                          : MYColor.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        status == "closed" ? "مغلق" : "مفتوح",
                        style: TextStyle(
                          color: status == "closed"
                              ? MYColor.buttons
                              : MYColor.success,
                          fontSize: 12,
                          fontFamily: 'montserrat_regular',
                        ),
                      ),
                    ),
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
                      "contract_id".tr,
                      style: TextStyle(
                        color: MYColor.black,
                        fontSize: 12,
                        fontFamily: 'montserrat_regular',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$contractID#",
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
                      "type".tr,
                      style: TextStyle(
                        color: MYColor.black,
                        fontSize: 12,
                        fontFamily: 'montserrat_regular',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      type,
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
                      "date".tr,
                      style: TextStyle(
                        color: MYColor.black,
                        fontSize: 12,
                        fontFamily: 'montserrat_regular',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      date,
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
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'montserrat_regular',
              ),
              strutStyle: const StrutStyle(
                height: 1.5,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
