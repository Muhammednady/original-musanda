import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/home/cities_model.dart';
import 'package:musaneda/app/modules/home/contracts_model.dart';
import 'package:musaneda/app/modules/home/nationalities_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../musaneda_model.dart';
import '../sliders_model.dart';

class HomeProvider extends GetConnect {
  final box = GetStorage();

  /// Get all Sliders from api
  Future<Sliders> getSliders() async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/sliders",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't get Sliders",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Sliders.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Musaneda from api
  Future<Musaneda> getMusaneda(int page) async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/musanedas?page=$page",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Musaneda.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Filter Musaneda from api by sending nationalities & age & marital status
  Future<Musaneda> getFilter(
      {national = 1, age = 1, marital = 1, page = 1}) async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/filter?page=$page&marital_status=$marital&age=$age&nationality=$national",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't find any filtered musaneda",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }
      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Musaneda.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Search Musaneda from api by sending name
  Future<Musaneda> getSearch(keyword) async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/search?keyword=$keyword",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't find any result",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }
      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Musaneda.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Contracts from api
  Future<Contracts> getContracts() async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/orders-history",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Sorry Can't fetch contracts",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Contracts.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Nationalities from api
  Future<Nationalities> getNationalities() async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/nationalities",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't fetch nationalities",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Nationalities.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Cities from api
  Future<Cities> getCities() async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/cities",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't fetch cities",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Cities.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
