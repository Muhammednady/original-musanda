class Status {
  int code;
  String description;
  String severity;

  Status({
    required this.code,
    required this.description,
    required this.severity,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      code: json['Code'],
      description: json['Description'],
      severity: json['Severity'],
    );
  }
}
