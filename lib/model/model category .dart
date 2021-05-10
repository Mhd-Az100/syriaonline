class CategoryModel {
  CategoryModel({
    this.serviceCatogaryId,
    this.picture,
    this.servicesCatogaryName,
  });

  final int serviceCatogaryId;
  final String picture;
  final String servicesCatogaryName;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        serviceCatogaryId: json["service_catogary_id"],
        picture: json["picture"],
        servicesCatogaryName: json["services_catogary_name"],
      );
}
