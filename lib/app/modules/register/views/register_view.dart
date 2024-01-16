import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/register/views/terms_and_conditions.dart';

import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myInkWell.dart';
import '../../../../components/myPreferredSize.dart';
import '../../../../config/myColor.dart';
import '../../../routes/app_pages.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myPreferredSize(
        title: LoginController.I.isSA() ? "app_name_sa".tr : "app_name".tr,
      ),
      body: GetBuilder(
        init: controller,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: controller.formRegisterKey,
              child: ListView(
                children: [
                  const SizedBox(height: 25),
                  Center(
                    child: Text(
                      "sign_up".tr,
                      style: TextStyle(
                        color: MYColor.buttons,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  _nameTextField(context),
                  const SizedBox(height: 10),
                  _phoneTextField(context),
                  const SizedBox(height: 10),
                  _iqamaTextField(context),
                  const SizedBox(height: 10),
                  _emailTextField(context),
                  const SizedBox(height: 10),
                  _passwordTextField(context),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          "by_clicking_on_create".tr,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      myInkWell(
                        fun: () {
                          termsAndConditions(
                              LanguageController.I.privacyPolicy);
                        },
                        text: "terms_and_conditions",
                        size: 14,
                        font: 'montserrat_regular',
                        color: MYColor.buttons,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: MyCupertinoButton(
                      btnColor: MYColor.buttons,
                      txtColor: MYColor.white,
                      text: "create_an_account".tr,
                      fun: () => controller.register(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "already_have_an_account".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      myInkWell(
                        fun: () {
                          Get.offAllNamed(Routes.LOGIN);
                        },
                        text: "sign_in".tr,
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

  /// full name text field
  TextFormField _nameTextField(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.name],
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
        // prefixText: "phone_number".tr,
        // hintText: "phone_number".tr,
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

  /// iqama text field
  TextFormField _iqamaTextField(BuildContext context) {
    return TextFormField(
      // autofillHints: const [AutofillHints.telephoneNumber],
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
      autofillHints: const [AutofillHints.email],
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
