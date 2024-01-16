import 'name_language_model.dart';

class Services {
  int? id;
  NameLanguage? title;

  Services({this.id, this.title});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title =
        json['title'] != null ? NameLanguage?.fromJson(json['title']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (title != null) {
      data['title'] = title?.toJson();
    }
    return data;
  }

  factory Services.fromMap(Map<String, dynamic> json) => Services(
        id: json["id"],
        title: json['name'] ?? '',
      );
}
