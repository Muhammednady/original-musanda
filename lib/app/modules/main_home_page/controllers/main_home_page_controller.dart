import 'package:get/get.dart';
import 'package:musaneda/app/modules/custom_payment/controllers/custom_payment_controller.dart';
import 'package:musaneda/app/modules/main_home_page/providers/main_home_page_provider.dart';
import 'package:musaneda/config/constance.dart';

import '../../../routes/app_pages.dart';
import '../../custom_payment/payment_response.dart';
import '../contract_model.dart';

class MainHomePageController extends GetxController {
  static MainHomePageController get I => Get.put(MainHomePageController());

  @override
  void onInit() {
    getContractList();
    setSelectedService = services.first;
    super.onInit();
  }

  final _tap = 0.obs;
  set setTap(int value) {
    _tap.value = value;
    update();
  }

  int get getTap => _tap.value;

  final _getSelectedService = 0.obs;

  set setSelectedService(ServiceData selectedService) {
    _getSelectedService.value = selectedService.id!;
    update();
  }

  int get getSelectedService => _getSelectedService.value;

  late ServiceData _serviceModel;
  set setServiceModel(ServiceData serviceModel) {
    _serviceModel = serviceModel;
    update();
  }

  ServiceData get getServiceModel => _serviceModel;

  final _duration = 1.obs;
  set setSelectedDuration(int value) {
    _duration.value = value;
    update();
  }

  int get getDuration => _duration.value;

  final _day = DateTime.now().day.obs;
  set selectedDay(int value) {
    _day.value = value;
    update();
  }

  int get getDay => _day.value;

  final _month = DateTime.now().month.obs;
  set selectedMonth(int value) {
    _month.value = value;
    update();
  }

  int get getMonth => _month.value;

  final _year = DateTime.now().year.obs;
  set selectedYear(int value) {
    _year.value = value;
    update();
  }

  int get getYear => _year.value;

  double get finalPrice {
    return ((Constance.checkDouble(getServiceModel.packages!.first.price) *
            getDuration) -
        finalDiscount);
  }

  double get beforeDiscount {
    return (Constance.checkDouble(getServiceModel.packages!.first.price) *
        getDuration);
  }

  double get finalDiscount {
    switch (getDuration) {
      case 1:
        return 0;
      case 3:
        return (getServiceModel.packages!.first.price! * 0.1);
      case 6:
        return (getServiceModel.packages!.first.price! * 0.2);
      case 12:
        return (getServiceModel.packages!.first.price! * 0.3);
      default:
        return 0;
    }
  }

  DateTime get startDate {
    return DateTime(getYear, getMonth, getDay);
  }

  DateTime get endDate {
    return DateTime(getYear, getMonth, getDay).add(Duration(days: getDuration));
  }

  List<ServiceData> services = [
    ServiceData(
      id: 1,
      name: 'cleaning'.tr,
      image: "assets/images/services/cleaning_with_background.svg",
      packages: [
        PackagesData(
          id: 1,
          name: "golden_package".tr,
          price: 6300.00,
          image: 'assets/images/packages/golden.png',
        ),
        PackagesData(
          id: 2,
          name: "silver_package".tr,
          price: 3900.00,
          image: 'assets/images/packages/silver.png',
        ),
        PackagesData(
          id: 3,
          name: "bronze_package".tr,
          price: 2700.00,
          image: 'assets/images/packages/bronze.png',
        ),
        PackagesData(
          id: 4,
          name: "platinum_package".tr,
          price: 1000.00,
          image: 'assets/images/packages/platinum.png',
        ),
      ],
    ),
    ServiceData(
      id: 2,
      name: 'washing'.tr,
      image: "assets/images/services/washing _with_background.svg",
      packages: [
        PackagesData(
          id: 1,
          name: "golden_package".tr,
          price: 4000.00,
          image: 'assets/images/packages/golden.png',
        ),
        PackagesData(
          id: 2,
          name: "silver_package".tr,
          price: 2200.00,
          image: 'assets/images/packages/silver.png',
        ),
        PackagesData(
          id: 3,
          name: "bronze_package".tr,
          price: 1600.00,
          image: 'assets/images/packages/bronze.png',
        ),
        PackagesData(
          id: 4,
          name: "platinum_package".tr,
          price: 900.00,
          image: 'assets/images/packages/platinum.png',
        ),
      ],
    ),
    ServiceData(
      id: 3,
      name: 'cooking'.tr,
      image: "assets/images/services/cooking_with_background.svg",
      packages: [
        PackagesData(
          id: 1,
          name: "golden_package".tr,
          price: 7200.00,
          image: 'assets/images/packages/golden.png',
        ),
        PackagesData(
          id: 2,
          name: "silver_package".tr,
          price: 6700.00,
          image: 'assets/images/packages/silver.png',
        ),
        PackagesData(
          id: 3,
          name: "bronze_package".tr,
          price: 6000.0,
          image: 'assets/images/packages/bronze.png',
        ),
        PackagesData(
          id: 4,
          name: "platinum_package".tr,
          price: 5400.0,
          image: 'assets/images/packages/platinum.png',
        ),
      ],
    ),
    ServiceData(
      id: 4,
      name: 'baby_sitting'.tr,
      image: "assets/images/services/child_care_with_background.svg",
      packages: [
        PackagesData(
          id: 1,
          name: "golden_package".tr,
          price: 4800.00,
          image: 'assets/images/packages/golden.png',
        ),
        PackagesData(
          id: 2,
          name: "silver_package".tr,
          price: 3400.00,
          image: 'assets/images/packages/silver.png',
        ),
        PackagesData(
          id: 3,
          name: "bronze_package".tr,
          price: 2600.00,
          image: 'assets/images/packages/bronze.png',
        ),
        PackagesData(
          id: 4,
          name: "platinum_package".tr,
          price: 2000.00,
          image: 'assets/images/packages/platinum.png',
        ),
      ],
    ),
  ];

  List<DurationData> durations = [
    DurationData(
      duration: 1,
    ),
    DurationData(
      duration: 3,
    ),
    DurationData(
      duration: 6,
    ),
    DurationData(
      duration: 12,
    ),
  ];

  void postOrderToServer(
      {required PaymentResponse response, isPaid, type}) async {
    Map<String, dynamic> data = {
      "service_id": getServiceModel.id,
      "package_id": getServiceModel.packages![getSelectedService].id,
      "duration": getDuration,
      "start_date": startDate.toString(),
      "end_date": endDate.toString(),
      "price": finalPrice,
      "is_paid": isPaid,
      "merchant_id": CustomPaymentController.I.merchantTransactionID,
    };

    MainHomePageProvider().postContractList(data).then(
      (res) {
        if (res.code == 1) {
          getContractList();
          Get.offAllNamed(Routes.MAIN_HOME_PAGE);
          // NotificationController.I.showNotify(
          //   id: 1,
          //   title: response.result.description,
          //   body: "${response.customer!.givenName} ${'your_order_with_id'.tr} ${response.resultDetails!.orderID} ${'is_success'.tr}",
          // );
        }
      },
    );

    update();
  }

  var contracts = List<ContractData>.empty(growable: true).obs;

  void getContractList() async {
    MainHomePageProvider().getContractList().then((res) {
      for (var e in res.data as List) {
        contracts.add(e);
      }
    });
    update();
  }

  void cancelOrder(int id) {
    MainHomePageProvider().cancelContractList(id).then((res) {
      if (res.code == 1) {
        contracts.removeWhere((e) => e.id == id);
        setTap = 1;
      }
    });
    update();
  }

  int generateDays() {
    var year = DateTime.now().year;
    int days = 0;
    if (getMonth == 2) {
      if (year % 4 == 0) {
        days = 29;
      } else {
        days = 28;
      }
    } else if (getMonth == 4 ||
        getMonth == 6 ||
        getMonth == 9 ||
        getMonth == 11) {
      days = 30;
    } else {
      days = 31;
    }

    if (getMonth == DateTime.now().month && getYear == DateTime.now().year) {
      days = days - DateTime.now().day + 1;
    }

    return days;
  }

  void payOrder({isPaid}) {
    Map data = {
      "order_id": CustomPaymentController.I.contractModel.value.id,
      "is_paid": isPaid,
      "merchant_id": CustomPaymentController.I.getMerchantTransactionID,
    };

    MainHomePageProvider().payOrder(data).then((res) {
      if (res.code == 1) {
        getContractList();
        setTap = 1;
        Get.back();
      }
    });
  }
}
