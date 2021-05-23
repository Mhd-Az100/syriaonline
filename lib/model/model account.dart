// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

List<Account> accountFromJson(String str) =>
    List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  Account({
    this.accountId,
    this.eMail,
    this.firstName,
    this.lastName,
    this.userPhoneNumber,
    this.password,
    this.accountTypeId,
    this.createdAt,
    this.updatedAt,
  });

  int accountId;
  final String eMail;
  final String firstName;
  final String lastName;
  final String userPhoneNumber;
  final dynamic password;
  final String accountTypeId;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        accountId: json["account_id"],
        eMail: json["e_mail"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userPhoneNumber: json["user_phone_number"],
        password: json["password"],
        accountTypeId: json["account_type_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "e_mail": eMail,
        "first_name": firstName,
        "last_name": lastName,
        "user_phone_number": userPhoneNumber,
        "password": password,
        "account_type_id": accountTypeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
