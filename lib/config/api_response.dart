import 'dart:convert';

class ApiResponse {
  int code;
  String message;

  ApiResponse({required this.code, required this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'ApiResponse{code: $code, message: $message}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiResponse &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          message == other.message;

  @override
  int get hashCode => code.hashCode ^ message.hashCode;

  ApiResponse copyWith({
    int? code,
    String? message,
  }) {
    return ApiResponse(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  List<Object> get props => [code, message];

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
    };
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      code: map['code'],
      message: map['message'],
    );
  }

  String toJsonString() => json.encode(toMap());

  factory ApiResponse.fromJsonString(String source) =>
      ApiResponse.fromMap(json.decode(source));
}
