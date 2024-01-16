import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/home/controllers/home_controller.dart';
import 'package:musaneda/components/myCupertinoButton.dart';

import '../../../../components/myMusaneda.dart';
import '../../../../config/myColor.dart';
import '../../../routes/app_pages.dart';

class SearchView extends GetView<HomeController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (ctx) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: MYColor.primary,
            title: SizedBox(
              height: 50,
              child: TextField(
                controller: controller.searchController,
                focusNode: controller.focusNode,
                onChanged: controller.getSearch,
                decoration: InputDecoration(
                  suffixStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: MYColor.white,
                  filled: true,
                  hintText: "search_by_name".tr,
                  hintStyle: TextStyle(
                    color: MYColor.greyDeep,
                    fontSize: 14,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.searchController.clear();
                      controller.getSearch("");
                    },
                    icon: Icon(
                      CupertinoIcons.clear_circled,
                      color: MYColor.buttons,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    height: 40,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: MYColor.primary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "search_results".tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'montserrat_medium',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                child: controller.check()
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/icon/no_result.svg",
                              height: 134.36,
                              width: 100,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "there_are_no_results".tr,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'montserrat_regular',
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 50,
                              width: 166,
                              child: MyCupertinoButton(
                                fun: () {
                                  controller.searchController.clear();
                                  controller.getSearch("");

                                  controller.setTap = 2;
                                  Get.back();
                                },
                                text: "see_musaneda".tr,
                                btnColor: MYColor.buttons,
                                txtColor: MYColor.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.count(),
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.MUSANEDA,
                                  arguments: controller
                                          .searchController.text.isNotEmpty
                                      ? controller.searchList[i]
                                      : controller.listMusaneda[i],
                                );
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: myMusanedaCard(
                                context: context,
                                name: controller
                                        .searchController.text.isNotEmpty
                                    ? LanguageController.I.getLocale == 'en'
                                        ? controller.searchList[i].name?.en!
                                            .toLowerCase()
                                        : controller.searchList[i].name?.ar!
                                            .toLowerCase()
                                    : LanguageController.I.getLocale == 'en'
                                        ? controller.listMusaneda[i].name?.en!
                                            .toLowerCase()
                                        : controller.listMusaneda[i].name?.ar!
                                            .toLowerCase(),
                                image: controller.listMusaneda[i].image,
                                country:
                                    controller.searchController.text.isNotEmpty
                                        ? LanguageController.I.getLocale == 'en'
                                            ? controller.searchList[i]
                                                .nationality?.name?.en
                                            : controller.searchList[i]
                                                .nationality?.name?.ar
                                        : LanguageController.I.getLocale == 'en'
                                            ? controller.listMusaneda[i]
                                                .nationality?.name?.en
                                            : controller.listMusaneda[i]
                                                .nationality?.name?.ar,
                                age:
                                    "${controller.searchController.text.isNotEmpty ? controller.searchList[i].age : controller.listMusaneda[i].age} ${"year".tr}",
                                about:
                                    controller.searchController.text.isNotEmpty
                                        ? LanguageController.I.getLocale == 'en'
                                            ? controller
                                                .searchList[i].description?.en
                                            : controller
                                                .searchList[i].description?.ar
                                        : LanguageController.I.getLocale == 'en'
                                            ? controller
                                                .listMusaneda[i].description?.en
                                            : controller.listMusaneda[i]
                                                .description?.ar,
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
