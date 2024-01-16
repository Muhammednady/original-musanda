// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/login/controllers/login_controller.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../components/myCupertinoButton.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final bool isReal;
  const ProfileView({Key? key, required this.isReal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (ctx) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: MYColor.transparent,
            title: Text(
              controller.enabled.value ? "update_profile".tr : "profile".tr,
              style: TextStyle(
                color: MYColor.buttons,
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: MYColor.black,
            ),
            leading: isReal
                ? IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: MYColor.primary,
                    ),
                    onPressed: () {
                      LoginController.I.logout();
                    },
                  )
                : null,
            actions: [
              if (!controller.enabled.value)
                IconButton(
                  onPressed: () {
                    controller.setEnabled = true;
                  },
                  icon: SvgPicture.asset(
                    "assets/images/icon/pencil.svg",
                    width: 20.31,
                    height: 20.31,
                  ),
                )
              else
                IconButton(
                  onPressed: () {
                    controller.setEnabled = false;
                  },
                  icon: const Icon(CupertinoIcons.xmark_rectangle),
                )
            ],
          ),
          body: Form(
            key: controller.formProfileKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 40),
                SvgPicture.asset(
                  "assets/images/drawer/user.svg",
                  color: MYColor.primary,
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 20),
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
                  'email'.tr,
                  style: TextStyle(
                    color: MYColor.buttons,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                _emailTextField(context),
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
                if (controller.enabled.value)
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: MyCupertinoButton(
                      btnColor: MYColor.buttons,
                      txtColor: MYColor.white,
                      text: "save_updates".tr,
                      fun: () => controller.postProfile(),
                    ),
                  )
                else
                  MyCupertinoButton(
                    fun: () {
                      // mySnackBar(
                      //   title: "remove_account".tr,
                      //   message: "msg_remove_account".tr,
                      //   color: MYColor.buttons,
                      //   icon: Icons.delete,
                      // );
                    },
                    btnColor: MYColor.buttons,
                    txtColor: MYColor.white,
                    text: "remove_account".tr,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// full name text field
  TextFormField _nameTextField(BuildContext context) {
    return TextFormField(
      enabled: controller.enabled.value,
      controller: controller.txtFullName,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      validator: (value) => controller.validateFullName(value!),
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
      enabled: controller.enabled.value,
      controller: controller.txtIqama,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: TextAlign.start,
      validator: (value) => controller.validateIqama(value!),
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

  /// email text field
  TextFormField _emailTextField(BuildContext context) {
    return TextFormField(
      enabled: controller.enabled.value,
      controller: controller.txtEmail,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => controller.validateEmail(value!),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "email".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: const Icon(CupertinoIcons.mail),
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
      enabled: controller.enabled.value,
      autofillHints: const [AutofillHints.telephoneNumber],
      controller: controller.txtPhone,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: TextAlign.left,
      validator: (value) => controller.validatePhone(value!),
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          child: Text(
            "966+",
            style: TextStyle(
              color: MYColor.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        hintText: "5XXXXXXX".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SizedBox(
            width: 103,
            child: Row(
              children: [
                const Icon(CupertinoIcons.phone),
                const SizedBox(width: 10),
                Text(
                  "phone_number".tr,
                  style: TextStyle(
                    color: MYColor.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
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
