// To parse this JSON data, do
//
//     final rateModel = rateModelFromJson(jsonString);

import 'dart:convert';

List<CommentModel> rateModelFromJson(String str) => List<CommentModel>.from(
    json.decode(str).map((x) => CommentModel.fromJson(x)));

String rateModelToJson(List<CommentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentModel {
  CommentModel({
    this.commentId,
    this.comment,
    this.picture,
    this.serviceId,
    this.accountId,
  });

  final int commentId;
  final String comment;
  final dynamic picture;
  final String serviceId;
  final String accountId;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentId: json["comment_id"],
        comment: json["comment"],
        picture: json["picture"],
        serviceId: json["service_id"],
        accountId: json["account_id"],
      );

  Map<String, dynamic> toJson() => {
        "comment_id": commentId,
        "comment": comment,
        "picture": picture,
        "service_id": serviceId,
        "account_id": accountId,
      };
}
