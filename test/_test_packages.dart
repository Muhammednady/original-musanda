import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musaneda/app/modules/order/packages_model.dart';
import 'package:musaneda/app/modules/order/providers/packages_provider.dart';
import 'package:musaneda/config/constance.dart';

void main() {
  test("test_stream", () async {});

  WidgetsFlutterBinding.ensureInitialized();

  PackagesProvider packagesProvider = PackagesProvider();
  //
  // test('test_branches', () async {
  //   Branches res = await packagesProvider.getBranches();
  //   res.data!.map((e) => Pretty.instance.logger.i(e.name!.ar)).toList();
  //   expect(res, isA<Branches>());
  // });

  test('test_packages', () async {
    Packages res = await packagesProvider.getPackages(theNationalID: 109);
    Pretty.instance.logger.i(res.code);
    expect(res, isA<Packages>());
  });
}
