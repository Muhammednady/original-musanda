import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myInkWell.dart';
import '../../../../components/myPreferredSize.dart';
import '../../../../config/myColor.dart';
import '../../../routes/app_pages.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/forget_controller.dart';

class ForgetView extends GetView<ForgetController> {
  const ForgetView({Key? key}) : super(key: key);
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
              key: controller.formForgetKey,
              child: ListView(
                children: [
                  const SizedBox(height: 25),
                  Center(
                    child: Text(
                      "reset_password".tr,
                      style: TextStyle(
                        color: MYColor.buttons,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  _phoneTextField(context),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: MyCupertinoButton(
                      btnColor: MYColor.buttons,
                      txtColor: MYColor.white,
                      text: "send_verification_code".tr,
                      fun: () => controller.forgotPassword(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "back_to_login".tr,
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
}
