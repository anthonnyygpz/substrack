class SubsEntity {
  final String? id;
  final String name;
  final String colorMembership;
  final bool? isActive;
  final List<SubsHistoryPaymentEntity>? historyPayment;

  SubsEntity({
    this.id,
    required this.name,
    required this.colorMembership,
    this.isActive,
    this.historyPayment,
  });
}

class SubsHistoryPaymentEntity {
  final DateTime startDate;
  final String membership;
  final int price;
  final int durationDay;

  SubsHistoryPaymentEntity({
    required this.startDate,
    required this.price,
    required this.membership,
    required this.durationDay,
  });
}
