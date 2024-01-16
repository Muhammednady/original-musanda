import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/home/controllers/home_controller.dart';

import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myDropdown.dart';
import '../../../../config/myColor.dart';
import '../controllers/delegation_controller.dart';
import '../delegations_model.dart';

class CreateDelegationView extends GetView<DelegationController> {
  final String action;
  final DelegationsData? delegations;

  const CreateDelegationView(
      {super.key, required this.action, this.delegations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text(
          action == 'create' ? 'add_delegation'.tr : 'update_delegation'.tr,
        ),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: DelegationController.I,
        builder: (ctx) {
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
                padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                child: Form(
                  key: controller.formDelegationKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'full_name'.tr,
                        style: TextStyle(
                          color: MYColor.buttons,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _nameTextField(context),
                      const SizedBox(height: 20),
                      Text(
                        'iqama_number'.tr,
                        style: TextStyle(
                          color: MYColor.buttons,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _iqamaTextField(context),
                      const SizedBox(height: 20),
                      Text(
                        'phone_number'.tr,
                        style: TextStyle(
                          color: MYColor.buttons,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _phoneTextField(context),
                      const SizedBox(height: 20),
                      Text(
                        'nationality'.tr,
                        style: TextStyle(
                          color: MYColor.buttons,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => myDropdown(
                          context: context,
                          value: controller.nationalityID.value,
                          onChanged: (value) {
                            controller.setNationalityID = value;
                          },
                          items: HomeController.I.listNationalities.map(
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
                                        ? item.name!.ar!
                                        : item.name!.en!,
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
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 52,
                        width: double.infinity,
                        child: MyCupertinoButton(
                          btnColor: MYColor.buttons,
                          txtColor: MYColor.white,
                          text: action == 'create' ? "add".tr : "edit".tr,
                          fun: () {
                            if (action == 'create') {
                              DelegationController.I.createDelegation();
                            } else {
                              DelegationController.I
                                  .updateDelegation(delegations!.id);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// full name text field
  TextFormField _nameTextField(BuildContext context) {
    return TextFormField(
      controller: DelegationController.I.txtFullName,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      validator: (value) => DelegationController.I.validateFullName(value!),
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "full_name".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: const Icon(CupertinoIcons.person),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }

  /// iqama text field
  TextFormField _iqamaTextField(BuildContext context) {
    return TextFormField(
      controller: DelegationController.I.txtIqama,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: TextAlign.start,
      validator: (value) => DelegationController.I.validateIqama(value!),
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "iqama_number".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: const Icon(CupertinoIcons.creditcard),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }

  /// phone text field
  TextFormField _phoneTextField(BuildContext context) {
    return TextFormField(
      controller: DelegationController.I.txtPhone,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: TextAlign.start,
      validator: (value) => DelegationController.I.validatePhone(value!),
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "phone_number".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: const Icon(CupertinoIcons.phone),
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
