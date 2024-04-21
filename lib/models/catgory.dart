import 'package:ato/providers/locale_provider.dart';

class CategoryModel {
  String id;
  String name;
  CategoryModel({required this.id, required this.name});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
    };
    return map;
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
    );
  }

  factory CategoryModel.fromOb(Object ob) {
    return ob as CategoryModel;
  }
}
