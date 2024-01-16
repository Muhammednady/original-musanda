import '../home/contracts_model.dart';

class Delegations {
  int? code;
  String? message;
  List<DelegationsData>? data;

  Delegations({this.code, this.message, this.data});

  Delegations.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DelegationsData>[];
      json['data'].forEach((v) {
        data?.add(DelegationsData.fromJson(v));
      });
    }
  }
}

class DelegationsData {
  int? id;
  String? name;
  String? iqama;
  Nationality? nationality;
  String? phone;
  int? status;

  DelegationsData(
      {this.id,
      this.name,
      this.iqama,
      this.nationality,
      this.phone,
      this.status});

  DelegationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iqama = json['iqama'];
    nationality = json['nationality'] != null
        ? Nationality?.fromJson(json['nationality'])
        : null;
    phone = json['phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iqama'] = iqama;
    if (nationality != null) {
      data['nationality'] = nationality?.toJson();
    }
    data['phone'] = phone;
    data['status'] = status;
    return data;
  }
}

class Nationality {
  int? id;
  Name? name;
  String? createdAt;
  String? updatedAt;

  Nationality({this.id, this.name, this.createdAt, this.updatedAt});

  Nationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name?.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name?.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
