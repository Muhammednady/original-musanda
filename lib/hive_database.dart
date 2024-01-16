import 'package:hive/hive.dart';

import 'app/modules/complaint/complaints_model.dart';

class HiveDatabase {
  String boxName = "musaneda";
  Type boxType = ComplaintsData;

  Future<Box> openBox() async {
    Box box = await Hive.openBox<Comparable>(boxName);
    return box;
  }

  List getComplaints(Box box) {
    return box.values.toList();
  }
}
