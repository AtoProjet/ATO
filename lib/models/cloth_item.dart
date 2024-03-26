import 'package:ato/models/item.dart';

class ClothModel extends ItemModel{
  String size;
  String forGender;
  String color;
  ClothModel(
      {required this.size,
      required this.forGender,
      required this.color, required super.id, required super.name, required super.categoryId, required super.quantity, required super.donorId, required super.details,
        super.image
});

  @override
  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "categoryId": categoryId,
      'size': size,
      'forGender': forGender,
      'color': color,
      'quantity': quantity,
      'donorId': donorId,
      'details': details,
      'image': image,
    };
    return map;
  }
  factory ClothModel.fromJson(Map<String, dynamic> json) {
    return ClothModel(
      size: json["size"],
      forGender: json["forGender"],
      color: json["color"],
      quantity: json["quantity"],
      donorId: json["donorId"],
      details: json["details"],
      image: json["image"],
      id: json["id"],
      name: json["name"],
      categoryId: json["categoryId"],
    );
  }

  factory ClothModel.fromOb(Object ob) {
    return ob as ClothModel;
  }
}
