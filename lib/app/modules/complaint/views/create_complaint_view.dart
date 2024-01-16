import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';

import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myDropdown.dart';
import '../../../../config/myColor.dart';
import '../controllers/complaint_controller.dart';

class CreateComplaintView extends GetView<ComplaintController> {
  const CreateComplaintView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('add_ticket'.tr),
        centerTitle: true,
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
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Form(
              key: ComplaintController.I.formComplaintKey,
              child: ListView(
                children: [
                  Text(
                    'ticket_name'.tr,
                    style: TextStyle(
                      color: MYColor.buttons,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _titleTextField(context),
                  const SizedBox(height: 10),
                  Text(
                    'notes'.tr,
                    style: TextStyle(
                      color: MYColor.buttons,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _notesTextField(context),
                  const SizedBox(height: 10),
                  Text(
                    'ticket_type'.tr,
                    style: TextStyle(
                      color: MYColor.buttons,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => myDropdown(
                      context: context,
                      value: controller.selectedTicketType.value,
                      onChanged: (value) {
                        controller.setTicketType = value;
                      },
                      items: controller.ticketTypes.map(
                        (item) {
                          return DropdownMenuItem(
                            value: item.id,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: Text(
                                LanguageController.I.getLocale == 'ar'
                                    ? item.name.ar!
                                    : item.name.en!,
                                style: TextStyle(
                                  color: MYColor.greyDeep,
                                  fontSize: 12,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'ticket_importance'.tr,
                    style: TextStyle(
                      color: MYColor.buttons,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => myDropdown(
                      context: context,
                      value: controller.selectedTicketPriority.value,
                      onChanged: (value) {
                        controller.setTicketPriority = value;
                      },
                      items: controller.ticketPriorities.map(
                        (item) {
                          return DropdownMenuItem(
                            value: item.id,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: Text(
                                LanguageController.I.getLocale == 'ar'
                                    ? item.name.ar!
                                    : item.name.en!,
                                style: TextStyle(
                                  color: MYColor.greyDeep,
                                  fontSize: 12,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Container(
                      width: Get.width,
                      height: 103,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () => controller.uploadFile(),
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.fileName.value.isEmpty
                                ? SvgPicture.asset(
                                    'assets/images/icon/attach.svg',
                                    width: 17.52,
                                    height: 19.5,
                                  )
                                : GestureDetector(
                                    onTap: () => controller.removeFile(),
                                    child: Icon(
                                      CupertinoIcons.bin_xmark,
                                      color: MYColor.primary,
                                    ),
                                  ),
                            const SizedBox(height: 10),
                            Text(
                              controller.fileName.value.isEmpty
                                  ? "upload_file".tr
                                  : controller.fileName.value,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'montserrat_light',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: MyCupertinoButton(
                      btnColor: MYColor.buttons,
                      txtColor: MYColor.white,
                      text: "add_ticket".tr,
                      fun: () => controller.createComplaint(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// title text field
  TextFormField _titleTextField(BuildContext context) {
    return TextFormField(
      controller: ComplaintController.I.txtTitle,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      validator: (value) => ComplaintController.I.validateTitleName(value!),
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "ticket_name".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }

  /// notes text field
  TextFormField _notesTextField(BuildContext context) {
    return TextFormField(
      maxLines: 4,
      controller: ComplaintController.I.txtNotes,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "notes".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
