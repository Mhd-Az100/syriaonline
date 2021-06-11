// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

import 'package:syriaonline/model/model%20services.dart';

List<SortService> serviceFromJson(String str) => List<SortService>.from(
    json.decode(str).map((x) => SortService.fromJson(x)));

String serviceToJson(List<SortService> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SortService {
  SortService({
    this.value,
    this.service,
  });

  final double value;
  final ServicesModel service;

  factory SortService.fromJson(json) => SortService(
        value: json["Value"].toDouble(),
        service: ServicesModel.fromJson(json["Service"]),
      );

  Map<String, dynamic> toJson() => {
        "Value": value,
        "SortService": service.toJson(),
      };
}
