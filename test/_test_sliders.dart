import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musaneda/app/modules/home/providers/home_provider.dart';
import 'package:musaneda/app/modules/home/sliders_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HomeProvider prd = HomeProvider();

  test("test fetch sliders", () async {
    Sliders sliders = await prd.getSliders();
    expect(sliders, isA<Sliders>());
  });
}
