class Register {
  int? code;
  RegisterData? data;

  Register({this.code, this.data});

  Register.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? RegisterData?.fromJson(json['data']) : null;
  }
}

class RegisterData {
  int? id;
  String? name;
  String? iqama;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? token;

  RegisterData(
      {this.id,
      this.name,
      this.iqama,
      this.phone,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.token});

  RegisterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iqama = json['iqama'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iqama'] = iqama;
    data['phone'] = phone;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['token'] = token;
    return data;
  }
}
