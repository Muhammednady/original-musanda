import 'package:musaneda/app/modules/home/name_language_model.dart';

class Nationalities {
  int? code;
  List<NationalitiesData>? data;

  Nationalities({this.code, this.data});

  Nationalities.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <NationalitiesData>[];
      json['data'].forEach((v) {
        data?.add(NationalitiesData.fromJson(v));
      });
    }
  }
}

class NationalitiesData {
  int? id;
  NameLanguage? name;

  NationalitiesData({this.id, this.name});

  NationalitiesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? NameLanguage?.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name?.toJson();
    }
    return data;
  }
}
