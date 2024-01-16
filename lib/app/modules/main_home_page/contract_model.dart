class Contract {
  int? code;
  String? message;
  List<ContractData>? data;

  Contract({this.code, this.message, this.data});

  Contract.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ContractData>[];
      json['data'].forEach((v) {
        data?.add(ContractData.fromJson(v));
      });
    }
  }
}

class ContractData {
  int? id;
  String? number;
  ServiceData? service;
  DurationData? duration;
  UserData? user;
  String? startDate;
  String? endDate;
  int? price;
  bool? isPaid;

  ContractData(
      {this.id,
      this.number,
      this.service,
      this.duration,
      this.user,
      this.startDate,
      this.endDate,
      this.price,
      this.isPaid});

  ContractData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    service =
        json['service'] != null ? ServiceData?.fromJson(json['service']) : null;
    duration = json['duration'] != null
        ? DurationData?.fromJson(json['duration'])
        : null;
    user = json['user'] != null ? UserData?.fromJson(json['user']) : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    price = json['price'];
    isPaid = json['is_paid'] == 1 ? true : false;
  }
}

class ServiceData {
  int? id;
  String? name;
  String? image;
  List<PackagesData>? packages;

  ServiceData({this.id, this.name, this.image, this.packages});

  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['packages'] != null) {
      packages = <PackagesData>[];
      json['packages'].forEach((v) {
        packages?.add(PackagesData.fromJson(v));
      });
    }
  }
}

class PackagesData {
  int? id;
  String? name;
  String? image;
  double? price;

  PackagesData({this.id, this.name, this.image, this.price});

  PackagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = double.parse(json['price'].toString());
  }
}

class DurationData {
  int? duration;
  String? durationName;

  DurationData({this.duration, this.durationName});

  DurationData.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    durationName = json['duration_name'];
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? iqama;

  UserData({this.id, this.name, this.email, this.phone, this.iqama});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    iqama = json['iqama'];
  }
}
