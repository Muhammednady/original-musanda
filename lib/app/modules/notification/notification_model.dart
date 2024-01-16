class FirebaseMessageModel {
  final String title;
  final String body;
  final String type;
  final String dateTime;

  const FirebaseMessageModel({
    required this.title,
    required this.body,
    required this.type,
    required this.dateTime,
  });

  factory FirebaseMessageModel.fromJson(Map<String, dynamic> json) {
    return FirebaseMessageModel(
      title: json["title"] ?? "",
      body: json["body"] ?? "",
      type: json['type'] ?? "",
      dateTime: json['date_time'] ?? "",
    );
  }
}
