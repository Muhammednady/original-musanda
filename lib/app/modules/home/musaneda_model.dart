class Musaneda {
  int? currentPage;
  List<MusanedaData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Musaneda(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Musaneda.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MusanedaData>[];
      json['data'].forEach((v) {
        data?.add(MusanedaData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class MusanedaData {
  int? id;
  Name? name;
  int? age;
  Education? education;
  Name? description;
  Nationality? nationality;
  Education? maritalStatus;
  String? image;
  String? video;
  String? resume;

  MusanedaData(
      {this.id,
      this.name,
      this.age,
      this.education,
      this.description,
      this.nationality,
      this.maritalStatus,
      this.image,
      this.video,
      this.resume});

  MusanedaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name?.fromJson(json['name']) : null;
    age = json['age'];
    education = json['education'] != null
        ? Education?.fromJson(json['education'])
        : null;
    description = json['description'] != null
        ? Name?.fromJson(json['description'])
        : null;
    nationality = json['nationality'] != null
        ? Nationality?.fromJson(json['nationality'])
        : null;
    maritalStatus = json['marital_status'] != null
        ? Education?.fromJson(json['marital_status'])
        : null;
    image = json['image'];
    video = json['video'];
    resume = json['resume'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name?.toJson();
    }
    data['age'] = age;
    if (education != null) {
      data['education'] = education?.toJson();
    }
    if (description != null) {
      data['description'] = description?.toJson();
    }
    if (nationality != null) {
      data['nationality'] = nationality?.toJson();
    }
    if (maritalStatus != null) {
      data['marital_status'] = maritalStatus?.toJson();
    }
    data['image'] = image;
    data['video'] = video;
    data['resume'] = resume;
    return data;
  }
}

class Name {
  String? ar;
  String? en;

  Name({this.ar, this.en});

  Name.fromJson(Map<String, dynamic> json) {
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

class Education {
  Name? name;

  Education({this.name});

  Education.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name?.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name?.toJson();
    }
    return data;
  }
}

class Nationality {
  int? id;
  Name? name;

  Nationality({this.id, this.name});

  Nationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name?.fromJson(json['name']) : null;
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
