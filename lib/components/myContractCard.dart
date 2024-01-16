// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/myColor.dart';

class MyContractCard extends StatelessWidget {
  final String title;
  final double price;
  final int duration;
  final double tax;
  final String status;
  final Function onTap;

  const MyContractCard({
    super.key,
    required this.title,
    required this.price,
    required this.duration,
    required this.tax,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 143,
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
                      width: 90,
                      decoration: BoxDecoration(
                        color: status == "pending"
                            ? Colors.orange.withOpacity(0.1)
                            : status == "active"
                                ? MYColor.success.withOpacity(0.1)
                                : status == "finished"
                                    ? MYColor.buttons.withOpacity(0.1)
                                    : Colors.yellow.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          status == "pending"
                              ? "pending".tr
                              : status == "active"
                                  ? "active".tr
                                  : status == "finished"
                                      ? "expired".tr
                                      : "cancelled".tr,
                          style: TextStyle(
                            color: status == "pending"
                                ? Colors.orange
                                : status == "active"
                                    ? MYColor.success
                                    : status == "finished"
                                        ? MYColor.buttons
                                        : Colors.yellow,
                            fontSize: 12,
                            fontFamily: 'montserrat_regular',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 10),

                  // InkWell(
                  //   onTap: () {},
                  //   child: SvgPicture.asset(
                  //     "assets/images/icon/contract.svg",
                  //     width: 18.75,
                  //     height: 25,
                  //   ),
                  // ),
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
                        "duration".tr,
                        style: TextStyle(
                          color: MYColor.black,
                          fontSize: 12,
                          fontFamily: 'montserrat_regular',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$duration ${"month".tr}',
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
                        "price".tr,
                        style: TextStyle(
                          color: MYColor.black,
                          fontSize: 12,
                          fontFamily: 'montserrat_regular',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$price ${"sar".tr}',
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
                        "tax".tr,
                        style: TextStyle(
                          color: MYColor.black,
                          fontSize: 12,
                          fontFamily: 'montserrat_regular',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "$tax",
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
      ),
    );
  }
}
