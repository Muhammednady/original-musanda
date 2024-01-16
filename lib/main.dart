import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/notification/controllers/notification_controller.dart';
import 'package:musaneda/app/modules/profile/controllers/profile_controller.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/controllers/language_controller.dart';
import 'app/modules/login/controllers/login_controller.dart';
import 'app/routes/app_pages.dart';
import 'config/myColor.dart';
import 'firebase_options.dart';

performance() async {
  final transaction = Sentry.startTransaction('processOrderBatch()', 'task');

  try {
    await processOrderBatch(transaction);
  } catch (exception) {
    transaction.throwable = exception;
    transaction.status = const SpanStatus.internalError();
  } finally {
    await transaction.finish();
  }
}

Future<void> processOrderBatch(ISentrySpan span) async {
  // span operation: task, span description: operation
  final innerSpan = span.startChild('task', description: 'operation');

  try {
    // omitted code
  } catch (exception) {
    innerSpan.throwable = exception;
    innerSpan.status = const SpanStatus.notFound();
  } finally {
    await innerSpan.finish();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "MUSANEDA",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // PushNotificationHandler.registerPushNotification();
  NotificationController().config();

  LanguageController.I.loadPrivacy();
  LanguageController.I.loadPrivacyPolicy();

  await GetStorage.init();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://d301f511b2ce4c39041ffc6c5019c12d@o4505695906693120.ingest.sentry.io/4505695907872768';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const App()),
  );
  configLoading();
  performance();
}

connectivity() async {
  if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}

/*
 * initialRoute() return initial route
 * if user is auth return main page
 * if user is not auth return login page
 */

initialRoute() {
  if (LoginController.I.isAuth()) {
    if (connectivity() == false) {
      return AppPages.MAIN_HOME_PAGE;
    } else {
      if (LoginController.I.isSA()) {
        return AppPages.MAIN;
      } else {
        return AppPages.MAIN_HOME_PAGE;
      }
    }
  } else {
    return AppPages.INITIAL;
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "musaneda",
      builder: EasyLoading.init(),
      getPages: AppPages.routes,
      initialRoute: initialRoute(),
      translations: LanguageController.I,
      fallbackLocale: LanguageController.I.fallbackLocale,
      locale: Locale(LanguageController.I.getLocale),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // primaryColor: MYColor.primary,
        fontFamily: 'montserrat_regular',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: MYColor.primary,
          secondary: MYColor.black,
        ),
        scaffoldBackgroundColor: MYColor.background,
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: MYColor.white,
            size: 20,
          ),
          titleTextStyle: TextStyle(
            fontFamily: 'montserrat_regular',
            color: MYColor.white,
            fontSize: 16,
          ),
        ),
      ),
      initialBinding: RootBinding(),
    );
  }
}

/*
 * configLoading() config loading
 *
 */
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ripple
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 70.0
    ..radius = 10.0
    ..progressColor = const Color(0xFFBF202E)
    ..backgroundColor = const Color(0xFFF7F8FA)
    ..indicatorColor = const Color(0xFFBF202E)
    ..textColor = const Color(0xFFBF202E)
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController());
  }
}
