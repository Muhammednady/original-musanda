class Login {
  int? code;
  LoginData? data;

  Login({this.code, this.data});

  Login.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? LoginData?.fromJson(json['data']) : null;
  }
}

class LoginData {
  int? id;
  String? name;
  String? iqama;
  String? phone;
  String? email;
  String? token;

  LoginData(
      {this.id, this.name, this.iqama, this.phone, this.email, this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iqama = json['iqama'];
    phone = json['phone'];
    email = json['email'];
    token = json['token'];
  }

  LoginData.fromLoginData(LoginData map) {
    id = map.id;
    name = map.name;
    iqama = map.iqama;
    phone = map.phone;
    email = map.email;

    token = map.token;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iqama'] = iqama;
    data['phone'] = phone;
    data['email'] = email;

    data['token'] = token;
    return data;
  }
}
