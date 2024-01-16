import 'package:musaneda/app/modules/home/musaneda_model.dart';

import '../../../config/constance.dart';

class Contracts {
  int? code;
  String? message;
  List<ContractsData>? data;

  Contracts({this.code, this.message, this.data});

  Contracts.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ContractsData>[];
      json['data'].forEach((v) {
        data?.add(ContractsData.fromJson(v));
      });
    }
  }
}

class ContractsData {
  int? id;
  String? status;
  String? contract;
  Package? package;
  User? user;
  MusanedaData? musaneda;
  String? createdAt;
  String? updatedAt;

  ContractsData(
      {this.id,
      this.status,
      this.contract,
      this.package,
      this.user,
      this.musaneda,
      this.createdAt,
      this.updatedAt});

  ContractsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    contract = json['contract'];
    package =
        json['package'] != null ? Package?.fromJson(json['package']) : null;
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    musaneda = json['musaneda'] != null
        ? MusanedaData?.fromJson(json['musaneda'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Package {
  int? id;
  Name? name;
  double? price;
  double? discount;
  int? duration;
  double? tax;
  double? total;
  String? createdAt;
  String? updatedAt;

  Package(
      {this.id,
      this.name,
      this.price,
      this.discount,
      this.duration,
      this.tax,
      this.total,
      this.createdAt,
      this.updatedAt});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name?.fromJson(json['name']) : null;
    price = Constance.checkDouble(json['price']);
    discount = Constance.checkDouble(json['discount']);
    duration = json['duration'];
    total = Constance.checkDouble(json['total']);
    tax = Constance.checkDouble(json['tax']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name?.toJson();
    }
    data['price'] = price;
    data['discount'] = discount;
    data['duration'] = duration;
    data['tax'] = tax;
    data['total'] = total;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  Name.fromJson(Map<String, dynamic> json) {
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

class User {
  int? id;
  String? name;
  String? iqama;
  String? phone;
  String? email;
  dynamic otp;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.iqama,
      this.phone,
      this.email,
      this.otp,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iqama = json['iqama'];
    phone = json['phone'];
    email = json['email'];
    otp = json['otp'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iqama'] = iqama;
    data['phone'] = phone;
    data['email'] = email;
    data['otp'] = otp;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
