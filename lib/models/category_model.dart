class CategoryModel {
  final String categoryName;
  final int id;

  CategoryModel({required this.categoryName, required this.id});

  factory CategoryModel.fromJson(json) {
    return CategoryModel(categoryName: json['category'], id: json['id']);
  }
}
