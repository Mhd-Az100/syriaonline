class CategoryModel {
  CategoryModel({
    this.serviceCatogaryId,
    this.picture,
    this.servicesCatogaryName,
    this.createdAt,
    this.updatedAt,
  });

  final int serviceCatogaryId;
  final String picture;
  final String servicesCatogaryName;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        serviceCatogaryId: json["service_catogary_id"],
        picture: json["picture"],
        servicesCatogaryName: json["services_catogary_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
