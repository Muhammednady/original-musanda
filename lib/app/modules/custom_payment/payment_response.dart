class PaymentResponse {
  String id;
  String paymentType;
  String paymentBrand;
  String amount;
  String currency;
  String descriptor;
  String merchantTransactionId;
  Result result;
  ResultDetails? resultDetails;
  Card? card;
  Customer? customer;
  Billing? billing;
  ThreeDSecure? threeDSecure;
  CustomParameters? customParameters;
  Risk? risk;
  String? buildNumber;
  String? timestamp;
  String? ndc;

  PaymentResponse(
      {required this.id,
      required this.paymentType,
      required this.paymentBrand,
      required this.amount,
      required this.currency,
      required this.descriptor,
      required this.merchantTransactionId,
      required this.result,
      this.resultDetails,
      this.card,
      this.customer,
      this.billing,
      this.threeDSecure,
      this.customParameters,
      this.risk,
      this.buildNumber,
      this.timestamp,
      this.ndc});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      id: json['id'],
      paymentType: json['paymentType'],
      paymentBrand: json['paymentBrand'],
      amount: json['amount'],
      currency: json['currency'],
      descriptor: json['descriptor'],
      merchantTransactionId: json['merchantTransactionId'],
      result: Result.fromJson(json['result']),
      resultDetails: json['resultDetails'] != null
          ? ResultDetails.fromJson(json['resultDetails'])
          : null,
      card: json['card'] != null ? Card.fromJson(json['card']) : null,
      customer:
          json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      billing:
          json['billing'] != null ? Billing.fromJson(json['billing']) : null,
      threeDSecure: json['threeDSecure'] != null
          ? ThreeDSecure.fromJson(json['threeDSecure'])
          : null,
      customParameters: json['customParameters'] != null
          ? CustomParameters.fromJson(json['customParameters'])
          : null,
      risk: json['risk'] != null ? Risk.fromJson(json['risk']) : null,
      buildNumber: json['buildNumber'],
      timestamp: json['timestamp'],
      ndc: json['ndc'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['paymentType'] = paymentType;
    data['paymentBrand'] = paymentBrand;
    data['amount'] = amount;
    data['currency'] = currency;
    data['descriptor'] = descriptor;
    data['merchantTransactionId'] = merchantTransactionId;
    data['result'] = result.toJson();
    if (resultDetails != null) {
      data['resultDetails'] = resultDetails?.toJson();
    }
    if (card != null) {
      data['card'] = card?.toJson();
    }
    if (customer != null) {
      data['customer'] = customer?.toJson();
    }
    if (billing != null) {
      data['billing'] = billing?.toJson();
    }
    if (threeDSecure != null) {
      data['threeDSecure'] = threeDSecure?.toJson();
    }
    if (customParameters != null) {
      data['customParameters'] = customParameters?.toJson();
    }
    if (risk != null) {
      data['risk'] = risk?.toJson();
    }
    data['buildNumber'] = buildNumber;
    data['timestamp'] = timestamp;
    data['ndc'] = ndc;
    return data;
  }
}

class Result {
  String code;
  String description;

  Result({required this.code, required this.description});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      code: json['code'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['description'] = description;
    return data;
  }
}

class ResultDetails {
  String? extendedDescription;
  String? procStatus;
  String? clearingInstituteName;
  String? authCode;
  String? connectorTxID1;
  String? connectorTxID3;
  String? connectorTxID2;
  String? acquirerResponse;
  String? externalSystemLink;
  String? termID;
  String? orderID;

  ResultDetails(
      {this.extendedDescription,
      this.procStatus,
      this.clearingInstituteName,
      this.authCode,
      this.connectorTxID1,
      this.connectorTxID3,
      this.connectorTxID2,
      this.acquirerResponse,
      this.externalSystemLink,
      this.termID,
      this.orderID});

  ResultDetails.fromJson(Map<String, dynamic> json) {
    extendedDescription = json['ExtendedDescription'];
    procStatus = json['ProcStatus'];
    clearingInstituteName = json['clearingInstituteName'];
    authCode = json['AuthCode'];
    connectorTxID1 = json['ConnectorTxID1'];
    connectorTxID3 = json['ConnectorTxID3'];
    connectorTxID2 = json['ConnectorTxID2'];
    acquirerResponse = json['AcquirerResponse'];
    externalSystemLink = json['EXTERNAL_SYSTEM_LINK'];
    termID = json['TermID'];
    orderID = json['OrderID'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ExtendedDescription'] = extendedDescription;
    data['ProcStatus'] = procStatus;
    data['clearingInstituteName'] = clearingInstituteName;
    data['AuthCode'] = authCode;
    data['ConnectorTxID1'] = connectorTxID1;
    data['ConnectorTxID3'] = connectorTxID3;
    data['ConnectorTxID2'] = connectorTxID2;
    data['AcquirerResponse'] = acquirerResponse;
    data['EXTERNAL_SYSTEM_LINK'] = externalSystemLink;
    data['TermID'] = termID;
    data['OrderID'] = orderID;
    return data;
  }
}

class Card {
  String? bin;
  String? binCountry;
  String? last4Digits;
  String? holder;
  String? expiryMonth;
  String? expiryYear;
  Issuer? issuer;
  String? type;
  String? country;
  String? maxPanLength;
  String? regulatedFlag;

  Card(
      {this.bin,
      this.binCountry,
      this.last4Digits,
      this.holder,
      this.expiryMonth,
      this.expiryYear,
      this.issuer,
      this.type,
      this.country,
      this.maxPanLength,
      this.regulatedFlag});

  Card.fromJson(Map<String, dynamic> json) {
    bin = json['bin'];
    binCountry = json['binCountry'];
    last4Digits = json['last4Digits'];
    holder = json['holder'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    issuer = json['issuer'] != null ? Issuer?.fromJson(json['issuer']) : null;
    type = json['type'];
    country = json['country'];
    maxPanLength = json['maxPanLength'];
    regulatedFlag = json['regulatedFlag'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bin'] = bin;
    data['binCountry'] = binCountry;
    data['last4Digits'] = last4Digits;
    data['holder'] = holder;
    data['expiryMonth'] = expiryMonth;
    data['expiryYear'] = expiryYear;
    if (issuer != null) {
      data['issuer'] = issuer?.toJson();
    }
    data['type'] = type;
    data['country'] = country;
    data['maxPanLength'] = maxPanLength;
    data['regulatedFlag'] = regulatedFlag;
    return data;
  }
}

class Issuer {
  String? bank;
  String? nA;
  String? website;
  String? phone;

  Issuer({this.bank, this.nA, this.website, this.phone});

  Issuer.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    nA = json['N.A.'];
    website = json['website'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bank'] = bank;
    data['N.A.'] = nA;
    data['website'] = website;
    data['phone'] = phone;
    return data;
  }
}

class Customer {
  String? givenName;
  String? surname;
  String? email;
  String? ip;
  String? ipCountry;

  Customer({this.givenName, this.surname, this.email, this.ip, this.ipCountry});

  Customer.fromJson(Map<String, dynamic> json) {
    givenName = json['givenName'];
    surname = json['surname'];
    email = json['email'];
    ip = json['ip'];
    ipCountry = json['ipCountry'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['givenName'] = givenName;
    data['surname'] = surname;
    data['email'] = email;
    data['ip'] = ip;
    data['ipCountry'] = ipCountry;
    return data;
  }
}

class Billing {
  String? street1;
  String? city;
  String? state;
  String? postcode;
  String? country;

  Billing({this.street1, this.city, this.state, this.postcode, this.country});

  Billing.fromJson(Map<String, dynamic> json) {
    street1 = json['street1'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['street1'] = street1;
    data['city'] = city;
    data['state'] = state;
    data['postcode'] = postcode;
    data['country'] = country;
    return data;
  }
}

class ThreeDSecure {
  String? eci;
  String? xid;
  String? paRes;

  ThreeDSecure({this.eci, this.xid, this.paRes});

  ThreeDSecure.fromJson(Map<String, dynamic> json) {
    eci = json['eci'];
    xid = json['xid'];
    paRes = json['paRes'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['eci'] = eci;
    data['xid'] = xid;
    data['paRes'] = paRes;
    return data;
  }
}

class CustomParameters {
  String? sHOPPERMSDKIntegrationType;
  String? sHOPPERDevice;
  String? cTPEDESCRIPTORTEMPLATE;
  String? sHOPPEROS;
  String? sHOPPERMSDKVersion;

  CustomParameters(
      {this.sHOPPERMSDKIntegrationType,
      this.sHOPPERDevice,
      this.cTPEDESCRIPTORTEMPLATE,
      this.sHOPPEROS,
      this.sHOPPERMSDKVersion});

  CustomParameters.fromJson(Map<String, dynamic> json) {
    sHOPPERMSDKIntegrationType = json['SHOPPER_MSDKIntegrationType'];
    sHOPPERDevice = json['SHOPPER_device'];
    cTPEDESCRIPTORTEMPLATE = json['CTPE_DESCRIPTOR_TEMPLATE'];
    sHOPPEROS = json['SHOPPER_OS'];
    sHOPPERMSDKVersion = json['SHOPPER_MSDKVersion'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['SHOPPER_MSDKIntegrationType'] = sHOPPERMSDKIntegrationType;
    data['SHOPPER_device'] = sHOPPERDevice;
    data['CTPE_DESCRIPTOR_TEMPLATE'] = cTPEDESCRIPTORTEMPLATE;
    data['SHOPPER_OS'] = sHOPPEROS;
    data['SHOPPER_MSDKVersion'] = sHOPPERMSDKVersion;
    return data;
  }
}

class Risk {
  String? score;

  Risk({this.score});

  Risk.fromJson(Map<String, dynamic> json) {
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['score'] = score;
    return data;
  }
}
