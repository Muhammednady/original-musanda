import 'package:musaneda/app/modules/order/status_model.dart';

class SingleBill {
  String invoiceId;
  String sadadNumber;
  Status status;

  SingleBill({
    required this.invoiceId,
    required this.sadadNumber,
    required this.status,
  });

  factory SingleBill.fromJson(Map<String, dynamic> json) {
    return SingleBill(
      invoiceId: json['InvoiceId'],
      sadadNumber: json['SADADNumber'],
      status: Status.fromJson(json['Status']),
    );
  }
}
