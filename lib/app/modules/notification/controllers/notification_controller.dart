// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/config/constance.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../controllers/language_controller.dart';
import '../notification_model.dart';

class NotificationController extends GetxController {
  Future<void> config() async {
    try {
      requestPermission();

      RemoteMessage? init =
          await FirebaseMessaging.instance.getInitialMessage();

      if (init != null) {
        _handleMessage(init);
        _handleOnMessage(init);
      }

      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

      FirebaseMessaging.onMessage.listen(_handleOnMessage);

      FirebaseMessaging.instance.getToken().then((token) {
        Pretty.instance.logger.d("on_get_token: $token");
        box.write('fcm_token', token);
      });

      FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        Pretty.instance.logger.d("on_token_refresh: $token");
      });
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  void _handleMessage(RemoteMessage message) async {
    try {
      Pretty.instance.logger.d("handle_message:$message");
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  void _handleOnMessage(RemoteMessage message) async {
    try {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Get.snackbar(
          notification.title!,
          notification.body!,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  void requestPermission() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        if (kDebugMode) {
          print("FCM: authorized");
        }
      }
      if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        if (kDebugMode) {
          print("FCM: provisional");
        }
      }

      update();
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  // static NotificationController get I => Get.find();
  final box = GetStorage();
  static final NotificationController _notifyService =
      NotificationController._internal();
  factory NotificationController() => _notifyService;
  NotificationController._internal();
  final FlutterLocalNotificationsPlugin fl = FlutterLocalNotificationsPlugin();
  Future<void> initNotify() async {
    try {
      FirebaseMessaging.instance.requestPermission();
      RemoteMessage? init =
          await FirebaseMessaging.instance.getInitialMessage();
      if (init != null) {
        log("init_notify_started", name: "init_notify_started");

        tz.initializeTimeZones();
        await fl.initialize(
          const InitializationSettings(
            android: AndroidInitializationSettings(
              '@drawable/notification',
            ),
            iOS: DarwinInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestSoundPermission: true,
            ),
          ),
        );

        FirebaseMessaging.onMessageOpenedApp.listen(
          (message) async {
            log("on_message_opened_app", name: "on_message_opened_app");
            Get.toNamed(Routes.NOTIFICATION);
          },
        );

        FirebaseMessaging.onMessage.listen(
          (message) async {
            FirebaseMessageModel frmModel = FirebaseMessageModel(
              title: message.notification!.title!,
              body: message.notification!.body!,
              type: message.data['type'],
              dateTime: since(date: message.data['date_time']),
            );

            notifyList.add(frmModel);

            Pretty.instance.logger.d(
              "${{
                'title': frmModel.title,
                'body': frmModel.body,
                'data': {
                  'type': message.data['type'],
                  'date_time': since(
                    date: message.data['date_time'], // 2022-12-26 11:40:00
                  ), // 2022-12-26 11:40:00
                },
              }}",
            );

            await showNotify(
              id: 1,
              title: frmModel.title,
              body: frmModel.body,
              type: frmModel.type,
            );
          },
        );

        FirebaseMessaging.instance.getToken().then(
          (token) {
            Pretty.instance.logger.d("get_token_tow: $token");
            box.write('fcm_token', token);
          },
        );
      }
      update();
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  var notifyList = <FirebaseMessageModel>[
    // FirebaseMessageModel(
    //   title: 'سداد فواتير',
    //   body: 'قد قمت بسداد الفاتورة رقم 352404134024 حى الله من جانا.',
    //   dateTime: since(date: "2022-12-15 09:40:30"),
    //   type: 'SADAD',
    // ),
    // FirebaseMessageModel(
    //   title: 'بطاقة إئتمان',
    //   body:
    //       'تم سداد المبلغ المستحق من بطاقة الائتمان رقم 352404134024 حى الله من جانا.',
    //   dateTime: since(date: "2022-12-15 09:50:30"),
    //   type: 'MADA',
    // ),
    // FirebaseMessageModel(
    //   title: 'Apple Pay',
    //   body:
    //       'تم سداد المبلغ المستحق من Apple Pay رقم 352404134024 حى الله من جانا.',
    //   dateTime: since(date: "2010-12-15 09:50:30"),
    //   type: 'APPLEPAY',
    // ),
  ];
  List<FirebaseMessageModel> get getNotify => notifyList;
  remove(FirebaseMessageModel ob) {
    if (getNotify.contains(ob)) {
      getNotify.remove(ob);
    }
    update();
  }

  Future<void> cancelAllNotifications() async {
    await fl.cancelAll();
    getNotify.clear();
    update();
  }

  tz.TZDateTime scheduled() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime date = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second,
    );
    if (date.isBefore(now)) {
      date = date.add(const Duration(seconds: 1));
    }
    return date;
  }

  static since({required String date, bool numeric = true}) {
    final DateTime dateTime = DateFormat.parse(date);
    // final DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
    final DateTime now = DateTime.now();

    final Duration difference = now.difference(dateTime);

    log(LanguageController.I.getLocale.toString(), name: "LOCALE");

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} ${LanguageController.I.getLocale == 'ar' ? 'سنة' : 'year'}';
    }
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} ${LanguageController.I.getLocale == 'ar' ? 'شهر' : 'month'}';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} ${LanguageController.I.getLocale == 'ar' ? 'يوم' : 'day'}';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours} ${LanguageController.I.getLocale == 'ar' ? 'ساعة' : 'hour'}';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${LanguageController.I.getLocale == 'ar' ? 'دقيقة' : 'minute'}';
    }
    return '${difference.inSeconds} ${LanguageController.I.getLocale == 'ar' ? 'ثانية' : 'second'}';
  }

  Future<void> showNotify({id, title, body, type}) async {
    await fl.zonedSchedule(
      id,
      title,
      body,
      scheduled(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'main_channel',
          'Main Channel',
          importance: Importance.max,
          priority: Priority.max,
          icon: '@drawable/notification',
        ),
        iOS: DarwinNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: false,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: type,
    );
    update();
  }
}

class DateFormat {
  static DateFormat get I => DateFormat('yyyy-MM-dd HH:mm:ss');

  DateFormat(String format);

  static DateTime parse(String date) {
    return DateTime.parse(date);
  }

  static String format(DateTime date) {
    return date.toString();
  }
}
