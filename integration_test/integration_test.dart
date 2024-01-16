import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:musaneda/app/modules/login/views/login_view.dart';
import 'package:musaneda/app/routes/app_pages.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Test Widgets binding initialization and routing logic.
  // testWidgets(
  //   'Test app initialization and routing',
  //   (WidgetTester tester) async {
  //     app.main();
  //
  //     await tester.(Duration(seconds: 7));
  //
  //     if (LoginController.I.isAuth()) {
  //       if (await app.connectivity() == false) {
  //         expect(find.byKey(const ValueKey('mainHomePage')), findsOneWidget);
  //       } else {
  //         if (LoginController.I.isSA()) {
  //           expect(find.byKey(const ValueKey('mainPage')), findsOneWidget);
  //         } else {
  //           expect(find.byKey(const ValueKey('mainHomePage')), findsOneWidget);
  //         }
  //       }
  //     } else {
  //       expect(find.byKey(const ValueKey('initialPage')), findsOneWidget);
  //     }
  //   },
  // );

  testWidgets('LoginView widget test', (WidgetTester tester) async {
    // Build the LoginView widget
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: Routes.LOGIN,
        getPages: AppPages.routes,
        home: const LoginView(),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byKey(const ValueKey("initialPage")), findsOneWidget);
    expect(find.text("sign_in".tr), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text("forgot_password".tr), findsOneWidget);
    expect(find.text("sign_in".tr), findsOneWidget);
    expect(find.text("do_not_have_an_account".tr), findsOneWidget);
    expect(find.text("create_one".tr), findsOneWidget);

    // Perform interactions
    await tester.enterText(find.byType(TextFormField).first, "568970184");
    await tester.enterText(find.byType(TextFormField).last, "12345678");
    await tester.tap(find.text("sign_in".tr));
    await tester.pumpAndSettle(const Duration(seconds: 7));

    // Verify the updated state after signing in
    expect(find.byKey(const ValueKey("initialPage")), findsNothing);
    expect(find.byType(TextFormField), findsNothing);
    expect(find.text("sign_in".tr), findsNothing);
    expect(find.text("do_not_have_an_account".tr), findsNothing);
    expect(find.text("create_one".tr), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // Add more assertions based on the expected behavior after signing in
  });
}
