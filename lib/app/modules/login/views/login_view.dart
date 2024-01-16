import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/components/myInkWell.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myPreferredSize.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey("initialPage"),
      appBar: myPreferredSize(
        title: LoginController.I.isSA() ? "app_name_sa".tr : "app_name".tr,
      ),
      body: GetBuilder(
        init: controller,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: controller.formLoginKey,
              child: ListView(
                children: [
                  const SizedBox(height: 25),
                  Center(
                    child: Text(
                      "sign_in".tr,
                      style: TextStyle(
                        color: MYColor.buttons,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  _phoneTextField(context),
                  const SizedBox(height: 10),
                  _passwordTextField(context),
                  const SizedBox(height: 25),
                  Align(
                    alignment: LanguageController.I.getLocale == "ar"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: myInkWell(
                      fun: () {
                        Get.toNamed(Routes.FORGET);
                      },
                      text: "forgot_password".tr,
                      size: 14,
                      font: 'montserrat_regular',
                      color: MYColor.buttons,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: MyCupertinoButton(
                      btnColor: MYColor.buttons,
                      txtColor: MYColor.white,
                      text: "sign_in".tr,
                      fun: () => controller.login(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "do_not_have_an_account".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      myInkWell(
                        fun: () {
                          Get.offAllNamed(Routes.REGISTER);
                        },
                        text: "create_one".tr,
                        size: 14,
                        font: 'montserrat_regular',
                        color: MYColor.buttons,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// phone text field
  TextFormField _phoneTextField(BuildContext context) {
    return TextFormField(
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

  /// password text field
  TextFormField _passwordTextField(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.password],
      controller: controller.txtPassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: controller.obscureText.value,
      validator: (value) => controller.validatePassword(value!),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "password".tr,
        hintStyle: TextStyle(
          color: MYColor.greyDeep,
          fontSize: 14,
        ),
        prefixIcon: const Icon(CupertinoIcons.padlock),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        suffixIcon: IconButton(
          splashRadius: 10,
          onPressed: () => controller.toggleObscureText(),
          icon: controller.getIcon(),
        ),
      ),
    );
  }
}
