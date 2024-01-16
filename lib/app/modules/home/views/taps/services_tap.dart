import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musaneda/app/modules/home/controllers/home_controller.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../../components/myFilterDialog.dart';
import '../../../../../components/myMusaneda.dart';
import '../../../../controllers/language_controller.dart';
import '../../../../routes/app_pages.dart';

Widget servicesTap(context) {
  final getLocal = LanguageController.I.getLocale;
  return Stack(
    children: [
      Stack(
        children: [
          Container(
            height: 40,
            width: Get.width,
            decoration: BoxDecoration(
              color: MYColor.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "services".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'montserrat_medium',
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    HomeController.I.setPrev();
                    HomeController.I.setTap = 1;
                    myFilterDialog(context);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      "assets/images/icon/filtter.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
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
      ),
      Padding(
        padding: const EdgeInsets.only(top: 90, left: 10, right: 10),
        child: Obx(
          () => LazyLoadScrollView(
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
                      final musaneda = HomeController.I.listMusaneda[i];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                                ? musaneda.name?.ar
                                : musaneda.name?.en,
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
      ),
    ],
  );
}
