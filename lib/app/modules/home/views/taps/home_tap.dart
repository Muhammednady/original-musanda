import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/home/controllers/home_controller.dart';

import '../../../../../components/myInkWell.dart';
import '../../../../../components/myMusaneda.dart';
import '../../../../../components/myServices.dart';
import '../../../../../config/myColor.dart';
import '../../../../routes/app_pages.dart';

Widget homeTap(context) {
  final getLocal = LanguageController.I.getLocale;
  return GetX(
    init: HomeController.I,
    builder: (ctx) {
      return ListView(
        children: [
          HomeController.I.listSliders.isEmpty
              ? Container(
                  height: 200,
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/png/slider_1.png",
                          ),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                )
              : CarouselSlider(
                  items: HomeController.I.listSliders.map(
                    (e) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: double.infinity,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/png/slider_1.png",
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    height: 159,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 1000,
                    ),
                    onPageChanged: (index, reason) {},
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Text(
              'services_include'.tr,
              style: TextStyle(
                color: MYColor.black,
                fontSize: 16,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const MyServices(left: 20, right: 20),
          const SizedBox(height: 5),
          const Divider(thickness: 4),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "best_services".tr,
                      style: TextStyle(
                        color: MYColor.primary,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    myInkWell(
                      fun: () {
                        HomeController.I.setTap = 2;
                      },
                      text: "see_all".tr,
                      size: 14,
                      font: 'montserrat_regular',
                      color: MYColor.greyDeep,
                    ),
                  ],
                ),
                // const SizedBox(height: 5),
                Column(
                  children: [
                    SizedBox(
                      height: Get.height / 2.6,
                      child: LazyLoadScrollView(
                        onEndOfPage: () {
                          HomeController.I.getMoreMusaneda();
                        },
                        isLoading: HomeController.I.lastPage.value,
                        child: HomeController.I.listMusaneda.isEmpty
                            ? Center(
                                child: Text(
                                  "no_musaneda_yet".tr,
                                  style: TextStyle(
                                    color: MYColor.greyDeep,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: HomeController.I.listMusaneda.length,
                                itemBuilder: (context, i) {
                                  final musaneda =
                                      HomeController.I.listMusaneda[i];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, top: 5),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.MUSANEDA,
                                          arguments: musaneda,
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: myMusanedaCard(
                                        context: context,
                                        name: getLocal == "ar"
                                            ? musaneda.name?.ar!.toLowerCase()
                                            : musaneda.name?.en!.toLowerCase(),
                                        image: musaneda.image,
                                        country: getLocal == "ar"
                                            ? musaneda.nationality?.name?.ar
                                            : musaneda.nationality?.name?.en,
                                        age: '${musaneda.age} ${'year'.tr}',
                                        about: getLocal == "ar"
                                            ? musaneda.description!.ar
                                            : musaneda.description!.en,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                    Visibility(
                      visible: HomeController.I.isLoading.value,
                      maintainAnimation: true,
                      maintainState: true,
                      maintainSize: true,
                      child: Center(
                        child: LoadingAnimationWidget.waveDots(
                          color: MYColor.primary,
                          size: 50,
                        ),
                        // child: LinearProgressIndicator(
                        //   minHeight: 1,
                        //   backgroundColor: MYColor.success,
                        //   valueColor: AlwaysStoppedAnimation<Color>(
                        //     MYColor.warning,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
