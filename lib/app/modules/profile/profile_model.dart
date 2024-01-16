class Profile {
  int? code;
  String? message;
  ProfileData? data;

  Profile({this.code, this.message, this.data});

  Profile.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? ProfileData?.fromJson(json['data']) : null;
  }
}

class ProfileData {
  int? id;
  String? name;
  String? phone;
  String? iqama;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  ProfileData({
    this.id,
    this.name,
    this.phone,
    this.iqama,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    iqama = json['iqama'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['iqama'] = iqama;
    data['email'] = email;
    return data;
  }
}
