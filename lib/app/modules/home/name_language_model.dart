class NameLanguage {
  String? ar;
  String? en;

  NameLanguage({this.ar, this.en});

  NameLanguage.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ar'] = ar;
    data['en'] = en;
    return data;
  }
}
