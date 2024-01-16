import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/home/musaneda_model.dart';
import 'package:musaneda/app/routes/app_pages.dart';

import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myServices.dart';
import '../../../../config/myColor.dart';
import '../controllers/musaneda_controller.dart';

class MusanedaView extends GetView<MusanedaController> {
  const MusanedaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MusanedaData musanedaData = Get.arguments;

    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const DetailScreen(),
                    arguments: musanedaData.image,
                  );
                },
                child: Hero(
                  tag: 'imageHero',
                  child: Container(
                    height: 350,
                    margin: const EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      // color: Colors.grey,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),

                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          musanedaData.image!,
                        ),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 50,
                          right: 10,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: SvgPicture.asset(
                              "assets/images/icon/back.svg",
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height / 3, left: 20, right: 20),
            child: Container(
              height: 130,
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
                          LanguageController.I.getLocale == "en"
                              ? musanedaData.name!.en!
                                  .substring(
                                    0,
                                    musanedaData.name!.en!.length > 20
                                        ? 20
                                        : musanedaData.name!.en!.length,
                                  )
                                  .toLowerCase()
                              : musanedaData.name!.ar!
                                  .substring(
                                    0,
                                    musanedaData.name!.ar!.length > 20
                                        ? 20
                                        : musanedaData.name!.ar!.length,
                                  )
                                  .toLowerCase(),
                          style: TextStyle(
                            color: MYColor.buttons,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/images/icon/video.svg",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            // controller.changeIsReady(false);
                            controller
                                .createFileOfPdfUrl(musanedaData.resume)
                                .then((f) {
                              // controller.changeIsReady(true);
                              Get.toNamed(
                                Routes.RESUME,
                                arguments: f.path,
                              );
                            });
                          },
                          child: SvgPicture.asset(
                            "assets/images/icon/pdf.svg",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
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
                              "education".tr,
                              style: TextStyle(
                                color: MYColor.buttons,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              LanguageController.I.getLocale == "en"
                                  ? "${musanedaData.education!.name!.en}"
                                  : "${musanedaData.education!.name!.ar}",
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "age".tr,
                              style: TextStyle(
                                color: MYColor.buttons,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${musanedaData.age} ${"year".tr} ",
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "nationality".tr,
                              style: TextStyle(
                                color: MYColor.buttons,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              LanguageController.I.getLocale == "en"
                                  ? "${musanedaData.nationality!.name!.en}"
                                  : "${musanedaData.nationality!.name!.ar}",
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
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
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Get.height / 2,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // height: 80,
                  child: Text(
                    LanguageController.I.getLocale == "en"
                        ? "${musanedaData.description!.en}"
                        : "${musanedaData.description!.ar}",
                    style: TextStyle(
                      color: MYColor.texts,
                      fontSize: 12,
                      fontFamily: 'montserrat_light',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'services_include'.tr,
                  style: TextStyle(
                    color: MYColor.buttons,
                    fontSize: 16,
                    fontFamily: 'montserrat_medium',
                  ),
                ),
                const SizedBox(height: 15),
                const MyServices(left: 0, right: 0),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: Text(
                    'language'.tr,
                    style: TextStyle(
                      color: MYColor.buttons,
                      fontSize: 12,
                      fontFamily: 'montserrat_medium',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1, bottom: 5),
                  child: Text(
                    LanguageController.I.getLocale == 'en'
                        ? 'English'.tr
                        : 'انجليزي'.tr,
                    style: TextStyle(
                      color: MYColor.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1, bottom: 10),
                  child: Text(
                    LanguageController.I.getLocale == 'en'
                        ? 'Intermediate arabic'.tr
                        : 'العربية بمستوى جيد'.tr,
                    style: TextStyle(
                      color: MYColor.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: MyCupertinoButton(
                      btnColor: MYColor.buttons,
                      txtColor: MYColor.white,
                      fun: () {
                        Get.toNamed(Routes.ORDER, arguments: musanedaData);
                      },
                      text: "service_request".tr,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Stack(
          children: <Widget>[
            Hero(
              tag: 'imageHero',
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: Get.arguments,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: MYColor.primary,
                      strokeWidth: 0.1,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 10,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: SvgPicture.asset(
                  "assets/images/icon/back.svg",
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
