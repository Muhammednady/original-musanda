class Message {
  MessagesModel message;
  int timestamp;
  String type;

  Message({
    required this.message,
    required this.timestamp,
    required this.type,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: MessagesModel.fromJson(json["message"]),
      timestamp: json["timestamp"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message.toJson(),
      "timestamp": timestamp,
      "type": type,
    };
  }
}

class MessagesModel {
  final String? id;
  final String text;
  final String type;
  final String? file;
  final String sender;

  MessagesModel({
    this.id,
    required this.text,
    required this.type,
    this.file = '',
    required this.sender,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      id: json["id"],
      text: json["text"],
      type: json["type"],
      file: json["file"],
      sender: json["sender"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "text": text,
      "type": type,
      "file": file,
      "sender": sender,
    };
  }
}
