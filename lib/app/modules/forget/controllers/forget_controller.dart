import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/forget/providers/forgot_provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../components/myCupertinoButton.dart';
import '../../../../components/myInkWell.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../../../routes/app_pages.dart';

class ForgetController extends GetxController {
  final formForgetKey = GlobalKey<FormState>();

  final formRestKey = GlobalKey<FormState>();

  RxBool obscureText = true.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
    update();
  }

  Icon getIcon() {
    return Icon(
      obscureText.value ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: MYColor.icons,
    );
  }

  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  /// OTP Code
  String appSignature = '';
  String otpCode = '';

  set setOtpCode(String? s) {
    otpCode = s!;
    update();
  }

  get getSignature => appSignature;

  void _getAppSignature() {
    SmsAutoFill().getAppSignature.then((signature) {
      appSignature = signature;
    });
    update();
  }

  @override
  void onInit() {
    super.onInit();

    _getAppSignature();
    _listenSmsCode();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
    update();
  }

  /// Create CountDown Timer
  final RxInt _start = 60.obs;
  RxInt get start => _start;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (_start.value == 0) {
        timer.cancel();
      } else {
        _start.value--;
      }
    });
  }

  void resetTimer() {
    _start.value = 60;
  }

  /// show dialog when register success
  void _showCodeDialog(context) {
    showDialog(
      context: context,
      anchorPoint: const Offset(0.5, 0.5),
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetAnimationCurve: Curves.easeInCirc,
          alignment: Alignment.center,
          child: Container(
            height: 330.0,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "verification_code".tr,
                  style: TextStyle(
                    color: MYColor.buttons,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    fontFamily: 'montserrat_medium',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "enter_the_code_sent_to".tr,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "enter_the_code_below".tr,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 250,
                  child: _pinTextField(context),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Text(
                    "${start.value} : 00",
                    style: TextStyle(
                      color: MYColor.buttons,
                      fontSize: 15,
                      fontFamily: 'montserrat_medium',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "did_not_receive_the_code".tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'montserrat_extra_light',
                      ),
                    ),
                    GetX(
                      init: ForgetController(),
                      builder: (ctx) {
                        // start.value == 0 ? resendOtp() : null,
                        return Visibility(
                          visible: start.value == 0,
                          child: myInkWell(
                            fun: () {
                              resetTimer();
                              startTimer();
                              resendOtp();
                            },
                            text: "resend_code".tr,
                            size: 14,
                            font: 'montserrat_extra_light',
                            color: MYColor.buttons,
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    update();
  }

  void _showRestDialog(context) {
    showDialog(
      context: context,
      anchorPoint: const Offset(0.5, 0.5),
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetAnimationCurve: Curves.easeInCirc,
          alignment: Alignment.center,
          child: Container(
            height: 350.0,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Form(
              key: formRestKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "change_password".tr,
                    style: TextStyle(
                      color: MYColor.buttons,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      fontFamily: 'montserrat_medium',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "enter_new_password".tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _passwordTextField(context),
                  const SizedBox(height: 10),
                  _confirmPasswordTextField(context),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: MyCupertinoButton(
                      btnColor: MYColor.buttons,
                      txtColor: MYColor.white,
                      text: "change".tr,
                      fun: () => restPassword(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    update();
  }

  validateOtp(context) {
    if (otpCode.isEmpty) {
      Get.snackbar(
        'error'.tr,
        "msg_plz_enter_otp".tr,
        colorText: Colors.black,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 800),
        icon: const Icon(
          Icons.error_outline,
          color: Color(0xFFBF202E),
        ),
      );
    } else if (otpCode.length != 4) {
      Get.snackbar(
        'error'.tr,
        "msg_plz_enter_correct_otp".tr,
        colorText: Colors.black,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 800),
        icon: const Icon(
          Icons.error_outline,
          color: Color(0xFFBF202E),
        ),
      );
    } else {
      postVerify(context);
    }
    update();
  }

  validatePassword(String value) {
    if (value.isEmpty) {
      return "msg_plz_enter_password".tr;
    } else if (value.length < 6) {
      return "msg_plz_enter_at_least_6_char".tr;
    }
    return null;
  }

  validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return "msg_plz_enter_confirm_password".tr;
    } else if (value.length < 6) {
      return "msg_plz_enter_at_least_6_char".tr;
    } else if (value != txtPassword.text) {
      return "msg_password_not_match".tr;
    }
    return null;
  }

  validatePhone(String value) {
    final regExp = RegExp(
      Constance.phoneRegExp,
      caseSensitive: false,
      multiLine: false,
    );
    if (value.isEmpty) {
      return "msg_plz_enter_phone".tr;
    } else if (!regExp.hasMatch(value)) {
      return "msg_plz_enter_correct_phone".tr;
    }
    return null;
  }

  /// password text field
  TextFormField _passwordTextField(BuildContext context) {
    return TextFormField(
      controller: txtPassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText.value,
      validator: (value) => validatePassword(value!),
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
          onPressed: () => toggleObscureText(),
          icon: getIcon(),
        ),
      ),
    );
  }

  /// password text field
  TextFormField _confirmPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: txtConfirmPassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText.value,
      validator: (value) => validateConfirmPassword(value!),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: "confirm_new_password".tr,
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
          onPressed: () => toggleObscureText(),
          icon: getIcon(),
        ),
      ),
    );
  }

  /// pin text field
  PinFieldAutoFill _pinTextField(BuildContext context) {
    return PinFieldAutoFill(
      keyboardType: TextInputType.number,
      autoFocus: true,
      cursor: Cursor(
        width: 2,
        color: MYColor.buttons,
        enabled: true,
      ),
      codeLength: 4,
      decoration: UnderlineDecoration(
        textStyle: TextStyle(
          fontSize: 28,
          color: MYColor.buttons.withOpacity(0.5),
          fontFamily: 'montserrat_semi_bold',
        ),
        colorBuilder: FixedColorBuilder(
          MYColor.buttons,
        ),
        gapSpace: 20,
        lineHeight: 2,
      ),
      currentCode: otpCode,
      smsCodeRegexPattern: r"\d{4}",
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      onCodeChanged: (code) {
        setOtpCode = code;
        if (code!.length == 4) {
          FocusScope.of(context).requestFocus(FocusNode());
          validateOtp(context);
        }
      },
    );
  }

  postVerify(context) {
    /// Send POST Request to Server for validate OTP Code
    Map data = {
      "phone": '+966${txtPhone.text}',
      "code": otpCode,
    };
    ForgotProvider().postVerify(data).then((value) {
      if (value == 1) {
        /// If success with code 1 then show dialog for OTP Code
        Get.back();
        resetTimer();

        _showRestDialog(context);
      }
    });
    update();
  }

  restPassword(context) {
    if (formRestKey.currentState!.validate()) {
      Map data = {
        "phone": "+966${txtPhone.text}",
        "code": otpCode,
        "password": txtPassword.text,
      };
      ForgotProvider().resetPassword(data).then((value) {
        if (value == 1) {
          Get.offAllNamed(Routes.LOGIN);
        }
      });
    }

    update();
  }

  forgotPassword(context) {
    if (formForgetKey.currentState!.validate()) {
      /// Send POST Request to Server for sending sms OTP
      Map data = {
        "phone": '+966${txtPhone.text}',
      };
      ForgotProvider().forgotPassword(data).then((value) {
        if (value == 1) {
          startTimer();

          /// If success with code 1 then show dialog for OTP Code
          _showCodeDialog(context);
        }
      });
    }
    update();
  }

  resendOtp() {
    Map data = {
      "phone": '+966${txtPhone.text}',
    };
    ForgotProvider().sendCode(data);
    startTimer();
    update();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }
}
