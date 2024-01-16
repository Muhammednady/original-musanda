import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../hyperpay/src/config.dart';
import '../hyperpay/src/enums/payment_mode.dart';

const appName = "musaneda";
const defaultLang = "ar";

const mapDefaultLatitude = 37.42796133580664;
const mapDefaultLongitude = (-122.085749655962);

const packageName = "com.fnrco.musaneda";
const merchantIDTestApplePay = "merchant.com.fnrco.musaneda.testApplePay";
const merchantIDLiveApplePay = "merchant.com.fnrco.musaneda.liveApplePay";

class TestConfig implements HyperpayConfig {
  @override
  String? creditcardEntityID = '8ac7a4c7820e3114018211080d2518e9';
  @override
  String? madaEntityID = '8ac7a4c7820e31140182110885b518ed';
  @override
  String? applePayEntityID = '8ac7a4c782187c3001821b83cc291a17';
  @override
  Uri checkoutEndpoint = _checkout;
  @override
  Uri statusEndpoint = _status;
  @override
  PaymentMode paymentMode = PaymentMode.test;
}

class LiveConfig implements HyperpayConfig {
  @override
  String? creditcardEntityID = '8acda4c7860d0a25018625c11cfb0aaf';
  @override
  String? madaEntityID = '8acda4c7860d0a25018625c1d3aa0ab6';
  @override
  String? applePayEntityID = '8acda4c7860d0a25018625c28fd80abb';
  @override
  Uri checkoutEndpoint = _checkout;
  @override
  Uri statusEndpoint = _status;
  @override
  PaymentMode paymentMode = PaymentMode.live;
}

String _host = 'kdamat.com';

Uri _checkout = Uri(
  scheme: 'https',
  host: _host,
  path: '/api/v1/checkouts',
);

Uri _status = Uri(
  scheme: 'https',
  host: _host,
  path: '/api/v1/payments',
);

class Pretty {
  Pretty._();
  static final Pretty instance = Pretty._();
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );
}

class Constance {
  Constance._();
  static final Constance instance = Constance._();

  static GetStorage box = GetStorage();

  final int id = box.read('LOGIN_MODEL')['id'] ?? '';
  final String name = box.read('LOGIN_MODEL')['name'] ?? '';
  final String email = box.read('LOGIN_MODEL')['email'] ?? '';
  final String phone = box.read('LOGIN_MODEL')['phone'] ?? '';
  final String iqama = box.read('LOGIN_MODEL')['iqama'] ?? '';
  final String token = box.read('LOGIN_MODEL')['token'] ?? '';
  final String testToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiN2VhOTQ0MDMxNDRmZTNmOTBkNjA4M2NjZTk1OTk0ZDVkMjM3YWY5YTNlYzQ3NTU2OWE2MmVmMjQ2MjMzNGIyYmFmZTQ0YzBlZWVmN2Y3MWEiLCJpYXQiOjE2ODQ2Njg0NDMuMTMwNjYwMDU3MDY3ODcxMDkzNzUsIm5iZiI6MTY4NDY2ODQ0My4xMzA2NjI5MTgwOTA4MjAzMTI1LCJleHAiOjE3MTYyOTA4NDMuMTI4NDM3OTk1OTEwNjQ0NTMxMjUsInN1YiI6IjU4OSIsInNjb3BlcyI6W119.G54AbOqK1y_Vtn99C8fK9DQDH7kaCbSl40k3IFoskLPwcE8-DsKNMAwHcuQrDBC5WyeltkWMuetTFaqyr83BB_xNm7THT5tj5iePfaCTo477oAzZn12xO602TKuJruli5qyRFn6SV37JBEB1vfUdeROYM2SAu2u-pm1izIjP3wlIbmCPk1BpAr811r0lwzzMJOp5icYA8emQJtqbhliCKLgM_p_rkL2CmxqLmHR64hpfpfRF3gRBAJPfiElyKZpFjndzv7PiHXYfpnTmb1tLd518ptNAWEukr3m8tpa-y_I8R56xti_Uf39ewlWw0qqBJEyXt_IGeW0rZ8KiHpvJahJ4SL9iqFqXHCAxr95Beo0F-fin2sHcG-xMHQQ53qPTX3GY-eEd4vfW4ZNMS8QHKBfqGNfWBbehYcueC5xnXQZP5zWHMengEDd54Xb_f-8UyxVdaTVJ0tUQbETP3JSiZovvYnu5xXRxwfR-hjr0XcP7yP0yidva6Y7LKQF5071Pm2zI6G5WWs9ICT0yQe6ACowOf1MH3qKWl36Sb4byGKjb8x9ZcbyR_UGCo0y3K4TDGEJsi4CvPBOjBQ_yQZaZ0qztL9-gW6HeVi8hUow-ftxbk4aDisuxgHnDKQHoPVd5fJTyW7ZfIilobQD-UHLEApDqXteLw5lh0NSlZtu5snw";

  static double checkDouble(dynamic value) {
    // check if value is null
    if (value == null) {
      return 0.0;
    }

    // check if value is empty string
    if (value is String && value.isEmpty) {
      return 0.0;
    }

    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }

  static const domain = "https://kdamat.com";

  static const apiEndpoint = "$domain/api/v1";

  static const mediaEndpoint = "$domain/storage/media/";

  static const String appName = "MUSANEDA";

  static const String appVersion = "1.0.0";

  static const String phoneRegExp =
      r'(^(5|9665|\5|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$)';
}

class Cards {
  String cardNumber;
  String expiryDate;
  int cvv;
  String type;
  String status;

  Cards({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.type,
    required this.status,
  });

  List<Cards> cards = [
    Cards(
      cardNumber: '4111 1111 1111 1111',
      expiryDate: '05/23',
      cvv: 123,
      type: 'mada',
      status: 'success',
    ),
    Cards(
      cardNumber: '5204 7300 0000 2514',
      expiryDate: '05/23',
      cvv: 251,
      status: 'fail',
      type: 'visa',
    ),
    Cards(
      cardNumber: '5297 4124 8444 2387',
      expiryDate: '10/22',
      cvv: 966,
      type: 'master',
      status: 'success',
    ),
  ];
}
