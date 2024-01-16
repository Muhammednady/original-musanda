import 'name_language_model.dart';

class Cities {
  int? code;
  List<CitiesData>? data;

  Cities({this.code, this.data});

  Cities.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <CitiesData>[];
      json['data'].forEach((v) {
        data?.add(CitiesData.fromJson(v));
      });
    }
  }
}

class CitiesData {
  int? id;
  NameLanguage? name;

  CitiesData({this.id, this.name});

  CitiesData.fromJson(Map<String, dynamic> json) {
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
