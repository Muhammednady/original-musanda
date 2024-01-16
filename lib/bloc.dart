import 'dart:convert';

import 'package:http/http.dart' as http;

class UserModel {
  final int id;
  final String name;
  final String email;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], name: json['name'], email: json['email']);
  }
}

// WebServices
class WebServices {
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse("uri"));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception("Web Service fetching error!");
    }
  }
}

// UserRepositories
class UserRepository {
  final WebServices webServices = WebServices();
  Future<List<UserModel>> fetchStudents() async {
    return await webServices.fetchUsers();
  }
}

// UserStats

// UserEvents

// UserBlocs

//
