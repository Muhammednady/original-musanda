import '../../../config/constance.dart';
import '../home/name_language_model.dart';

class Packages {
  int? code;
  List<PackagesData>? data;

  Packages({this.code, this.data});

  Packages.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <PackagesData>[];
      json['data'].forEach((v) {
        data?.add(PackagesData.fromJson(v));
      });
    }
  }
}

class PackagesData {
  int? id;
  NameLanguage? name;
  double? price;
  double? discount;
  int? duration;
  double? total;
  double? tax;

  PackagesData(
      {this.id,
      this.name,
      this.price,
      this.discount,
      this.duration,
      this.total,
      this.tax});

  PackagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? NameLanguage?.fromJson(json['name']) : null;
    price = Constance.checkDouble(json['price']);
    discount = Constance.checkDouble(json['discount']);
    duration = json['duration'];
    total = Constance.checkDouble(json['total']);
    tax = Constance.checkDouble(json['tax']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['title'] = name?.toJson();
    }
    data['price'] = price;
    data['discount'] = discount;
    data['duration'] = duration;
    data['total'] = total;
    data['tax'] = tax;
    return data;
  }
}
