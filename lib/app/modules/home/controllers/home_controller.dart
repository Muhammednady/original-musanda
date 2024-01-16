import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/home/contracts_model.dart';
import 'package:musaneda/app/modules/home/musaneda_model.dart';
import 'package:musaneda/app/modules/home/name_language_model.dart';
import 'package:musaneda/app/modules/home/nationalities_model.dart';
import 'package:musaneda/app/modules/home/providers/home_provider.dart';
import 'package:musaneda/app/modules/home/sliders_model.dart';
import 'package:musaneda/app/modules/home/views/filter_view.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../cities_model.dart';

class AgeRange {
  int id;
  NameLanguage name;

  AgeRange({required this.id, required this.name});
}

class MaritalStatus {
  int id;
  NameLanguage name;

  MaritalStatus({required this.id, required this.name});
}

class HomeController extends GetxController {
  static HomeController get I => Get.find();
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();

  packageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageNames.value = packageInfo.packageName;
    versions.value = packageInfo.version;
    buildNumbers.value = packageInfo.buildNumber;
  }

  final packageNames = ''.obs;
  final versions = ''.obs;
  final buildNumbers = ''.obs;

  var box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    packageInfo();
    getCities();
    getNationalities();
    getContracts();
    getMusaneda();
    getSliders();
  }

  final tap = 0.obs;
  final prev = 0.obs;

  setPrev() {
    prev.value = tap.value;
    update();
  }

  backTap() {
    setTap = prev.value;
    update();
  }

  set setTap(value) {
    tap.value = value;
    update();
  }

  RxBool isLoading = false.obs;

  var listSliders = List<SliderData>.empty(growable: true).obs;

  Future<void> getSliders() async {
    isLoading(true);
    HomeProvider().getSliders().then((value) {
      for (var data in value.data as List) {
        listSliders.add(data);
      }
      isLoading(false);
    });

    update();
  }

  var listMusaneda = List<MusanedaData>.empty(growable: true).obs;
  var page = 1.obs;
  var lastPage = false.obs;

  Future<void> getMusaneda() async {
    isLoading(true);
    HomeProvider().getMusaneda(page.value).then(
      (value) {
        for (var data in value.data as List) {
          listMusaneda.add(data);
        }
        isLoading(false);
      },
    );
    update();
  }

  Future<void> getMoreMusaneda() async {
    isLoading(true);
    HomeProvider().getMusaneda(page.value++).then(
      (value) {
        for (var data in value.data as List) {
          listMusaneda.add(data);
        }
        isLoading(false);
        if (value.lastPage! <= page.value) {
          lastPage(true);
        }
      },
    );
    update();
  }

  var listContracts = List<ContractsData>.empty(growable: true).obs;
  var listActive = List<ContractsData>.empty(growable: true).obs;
  var listFinished = List<ContractsData>.empty(growable: true).obs;

  Future<void> getContracts() async {
    isLoading(true);
    HomeProvider().getContracts().then((value) {
      for (var data in value.data as List) {
        listContracts.add(data);
        if (data.status == "active") {
          listActive.add(data);
        }
        if (data.status == "finished") {
          listFinished.add(data);
        }
      }
      isLoading(false);
    });

    update();
  }

  var listNationalities = List<NationalitiesData>.empty(growable: true).obs;

  Future<void> getNationalities() async {
    listNationalities.add(
      NationalitiesData(
        id: 0,
        name: NameLanguage(
          ar: "اختر الجنسيه",
          en: "Select Nationality",
        ),
      ),
    );

    isLoading(true);
    HomeProvider().getNationalities().then((value) {
      for (var data in value.data as List) {
        listNationalities.add(data);
      }
      isLoading(false);
    });

    update();
  }

  var listCities = List<CitiesData>.empty(growable: true).obs;

  Future<void> getCities() async {
    listCities.add(
      CitiesData(
        id: 0,
        name: NameLanguage(
          ar: "اختر المدينه",
          en: "Select City",
        ),
      ),
    );
    isLoading(true);
    HomeProvider().getCities().then((value) {
      for (var data in value.data as List) {
        listCities.add(data);
      }
      isLoading(false);
    });

    update();
  }

  /// On tap on second tab which is the add service tab
  /// We will show dialog to add service and then we will
  /// Filter the list of services and show it in the list

  var nationality = 0.obs;

  List<NationalitiesData> nationalityList = [
    NationalitiesData(
      id: 0,
      name: NameLanguage(
        ar: "اختر الجنسيه",
        en: "Select nationality",
      ),
    ),
    NationalitiesData(
      id: 101,
      name: NameLanguage(
        ar: "اندونيسيا",
        en: "Indonesia",
      ),
    ),
    NationalitiesData(
      id: 114,
      name: NameLanguage(
        ar: "كينيا",
        en: "Kenya",
      ),
    ),
    NationalitiesData(
      id: 176,
      name: NameLanguage(
        ar: "الفلبين",
        en: "Philippines",
      ),
    ),
  ];

  set setNationality(setBranch) {
    nationality.value = setBranch;
    update();
  }

  List<AgeRange> ages = [
    AgeRange(
      id: 0,
      name: NameLanguage(
        ar: 'اختر الفئة العمرية',
        en: 'Select Age Range',
      ),
    ),
    AgeRange(
      id: 1,
      name: NameLanguage(
        ar: 'من 18 الى 25',
        en: 'From 18 to 25',
      ),
    ),
    AgeRange(
      id: 2,
      name: NameLanguage(
        ar: 'من 26 الى 35',
        en: 'From 26 to 35',
      ),
    ),
    AgeRange(
      id: 3,
      name: NameLanguage(
        ar: 'اكبر من 36',
        en: 'More than 36',
      ),
    ),
  ];

  // case 1: from 18 to  25 or between 18 and 25
  // case 2: from 26 to 35 or between 26 and 35
  // case 3: more than 36 or greater than 36

  RxInt a = 0.obs;

  set setAge(setAge) {
    a.value = setAge;
  }

  // '1' => 'single',
  // '2' => 'married',
  // '3' => 'widow',
  // '4' => 'divorced',
  // '5' => 'undefined',

  List<MaritalStatus> maritalList = [
    MaritalStatus(
      id: 0,
      name: NameLanguage(
        ar: 'اختر الحالة الاجتماعية',
        en: 'Select Marital Status',
      ),
    ),
    MaritalStatus(
      id: 1,
      name: NameLanguage(
        ar: 'عزباء',
        en: 'Single',
      ),
    ),
    MaritalStatus(
      id: 2,
      name: NameLanguage(
        ar: 'متزوجه',
        en: 'Married',
      ),
    ),
    MaritalStatus(
      id: 3,
      name: NameLanguage(
        ar: 'ارمله',
        en: 'Widow',
      ),
    ),
    MaritalStatus(
      id: 4,
      name: NameLanguage(
        ar: 'مطلقه',
        en: 'Divorced',
      ),
    ),
  ];

  RxInt maritalStatus = 0.obs;

  set setMarital(setMarital) {
    maritalStatus.value = setMarital;
  }

  var listFilter = List<MusanedaData>.empty(growable: true).obs;

  Future<void> getFilter() async {
    isLoading(true);
    HomeProvider()
        .getFilter(
      national: nationality.value,
      age: a.value,
      marital: maritalStatus.value,
      page: page.value,
    )
        .then(
      (res) {
        listFilter.clear();
        for (var data in res.data as List) {
          listFilter.add(data);
        }
        isLoading(false);
        Get.to(() => const FilterView());
      },
    );

    update();
  }

  Future<void> getMoreFilter() async {
    isLoading(true);
    HomeProvider()
        .getFilter(
            national: nationality.value,
            age: a.value,
            marital: maritalStatus.value,
            page: page.value)
        .then((res) {
      for (var data in res.data as List) {
        listFilter.add(data);
      }
      isLoading(false);
      if (res.lastPage! <= page.value) {
        lastPage(true);
      }
    });
    update();
  }

  /// Search for musaneda
  final FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  List<MusanedaData> searchList = [];

  /// check if the search is empty or not
  bool check() {
    return searchController.text.isNotEmpty && searchList.isEmpty;
  }

  /// count the number of musaneda
  int count() {
    return searchController.text.isNotEmpty
        ? searchList.length
        : listMusaneda.length;
  }

  /// search for musaneda on the api {db} and show it in the list
  getSearch(String value) {
    searchList.clear();
    HomeProvider().getSearch(value).then((res) {
      for (var data in res.data as List) {
        searchList.add(data);
      }
      update();
    });
    update();
  }

  /// on change search Search in the existing list of musaneda
  // onChanged(String value) {
  //   if (value.isNotEmpty) {
  //     searchList = listMusaneda.where((e) {
  //       if (value.codeUnitAt(0) >= 65 && value.codeUnitAt(0) <= 122) {
  //         return e.name?.en?.toLowerCase().contains(value.toLowerCase()) ??
  //             false;
  //       } else {
  //         return e.name?.ar?.toLowerCase().contains(value.toLowerCase()) ??
  //             false;
  //       }
  //     }).toList();
  //
  //     if (searchController.text.isNotEmpty && searchList.isEmpty) {
  //       if (kDebugMode) {
  //         print("$value : Not found on list");
  //       }
  //     }
  //   }
  //   update();
  // }

  @override
  void onClose() {
    focusNode.dispose();
    searchController.dispose();
    super.onClose();
  }
}
