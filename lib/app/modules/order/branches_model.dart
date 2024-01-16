class Branches {
  int? code;
  String? message;
  List<BranchesData>? data;

  Branches({this.code, this.message, this.data});

  Branches.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BranchesData>[];
      json['data'].forEach((v) {
        data?.add(BranchesData.fromJson(v));
      });
    }
  }
}

class BranchesData {
  int? id;
  NameLanguage? name;

  BranchesData({this.id, this.name});

  BranchesData.fromJson(Map<String, dynamic> json) {
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

class NameLanguage {
  String? en;
  String? ar;

  NameLanguage({this.en, this.ar});

  NameLanguage.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}
