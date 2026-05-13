class CompleteReservationRequestModel {
  double? amountDollar;
  double? amountEuro;
  double? amountPound;
  double? amountLira;
  String? notes;

  CompleteReservationRequestModel({
    this.amountDollar,
    this.amountEuro,
    this.amountPound,
    this.amountLira,
    this.notes,
  });

  // From JSON
  factory CompleteReservationRequestModel.fromJson(Map<String, dynamic> json) {
    return CompleteReservationRequestModel(
      amountDollar: json['amount_doller'] ?? 0,
      amountEuro: json['amount_euro'] ?? 0,
      amountPound: json['amount_pound'] ?? 0,
      amountLira: json['amount_lira'] ?? 0,
      notes: json['notes'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'amount_doller': amountDollar ?? 0,
      'amount_euro': amountEuro ?? 0,
      'amount_pound': amountPound ?? 0,
      'amount_lira': amountLira ?? 0,
      'notes': notes ?? '',
    };
  }
}
