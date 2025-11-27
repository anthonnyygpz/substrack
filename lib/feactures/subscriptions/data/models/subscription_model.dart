import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionModel {
  final String? id;
  final String serviceName;
  final int priceInCents;
  final String? currency;
  final String planName;
  final String colorMembership;
  final List<PaymentHistoryModel>? paymentHistory;
  final String? userId;
  final DateTime nextPaymentDate;
  final String? status;
  final String category;
  final String? logoUrl;
  final bool? remindMe;
  final DateTime? startDate;

  SubscriptionModel({
    this.id,
    this.userId,
    required this.serviceName,
    required this.colorMembership,
    required this.planName,
    required this.priceInCents,
    this.paymentHistory,
    this.currency,
    required this.nextPaymentDate,
    this.status,
    required this.category,
    this.logoUrl,
    this.remindMe = true,
    this.startDate,
  });

  SubscriptionModel copyWith({
    String? id,
    String? userId,
    String? serviceName,
    String? planName,
    String? colorMembership,
    int? priceInCents,
    bool? isActive,
    List<PaymentHistoryModel>? paymentHistory,
    String? currency,
    DateTime? nextPaymentDate,
    String? status,
    String? category,
    String? logoUrl,
    bool? remindMe,
    DateTime? startDate,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      planName: planName ?? this.planName,
      priceInCents: priceInCents ?? this.priceInCents,
      userId: userId ?? this.userId,
      serviceName: serviceName ?? this.serviceName,
      colorMembership: colorMembership ?? this.colorMembership,
      paymentHistory: paymentHistory ?? this.paymentHistory,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      category: category ?? this.category,
      logoUrl: logoUrl ?? this.logoUrl,
      remindMe: remindMe ?? this.remindMe,
      startDate: startDate ?? this.startDate,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "userId": userId,
      "serviceName": serviceName,
      "planName": planName,
      "priceInCents": priceInCents,
      "colorMembership": colorMembership,
      "paymentHistory": paymentHistory?.map((x) => x.toMap()).toList(),
      "currency": currency,
      "nextPaymentDate": nextPaymentDate,
      "category": category,
      "logoUrl": logoUrl,
      "remindMe": remindMe,
      "startDate": startDate,
    };
  }

  factory SubscriptionModel.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SubscriptionModel(
      id: doc.id,
      userId: data['userId'],
      serviceName: data['serviceName'],
      priceInCents: data['priceInCents'],
      planName: data['planName'],
      colorMembership: data['colorMembership'],
      paymentHistory: (data['paymentHistory'] as List<dynamic>?)
          ?.map((e) => PaymentHistoryModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      currency: data['currency'],
      nextPaymentDate: data['nextPaymentDate'] is Timestamp
          ? (data['nextPaymentDate'] as Timestamp).toDate()
          : data['nextPaymentDate'],
      status: data['status'],
      category: data['category'],
      logoUrl: data['logoUrl'],
      remindMe: data['remindMe'],
      startDate: data['startDate'] is Timestamp
          ? (data['startDate'] as Timestamp).toDate()
          : data['startDate'],
    );
  }

  factory SubscriptionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return SubscriptionModel.fromSnapshot(snapshot);
  }
}

class PaymentHistoryModel {
  final DateTime date;
  final int amountPaid;

  PaymentHistoryModel({required this.date, required this.amountPaid});

  Map<String, dynamic> toMap() {
    return {'date': Timestamp.fromDate(date), 'amountPaid': amountPaid};
  }

  factory PaymentHistoryModel.fromMap(Map<String, dynamic> map) {
    return PaymentHistoryModel(
      date: (map['date'] as Timestamp).toDate(),
      amountPaid: map['amountPaid'],
    );
  }
}

// class SubscriptionEditModel {
// SubscriptionEditModel({this.});
//
// }
