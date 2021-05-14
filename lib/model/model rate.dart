// To parse this JSON data, do
//
//     final rateModel = rateModelFromJson(jsonString);

class RateModel {
  RateModel({
    this.rateId,
    this.rateFrom5,
    this.serviceId,
    this.accountId,
    this.createdAt,
    this.updatedAt,
  });

  final int rateId;
  final String rateFrom5;
  final String serviceId;
  final String accountId;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
        rateId: json["rate_id"],
        rateFrom5: json["rate_from_5"],
        serviceId: json["service_id"],
        accountId: json["account_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "rate_id": rateId,
        "rate_from_5": rateFrom5,
        "service_id": serviceId,
        "account_id": accountId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
