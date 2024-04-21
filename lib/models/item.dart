import 'package:ato/providers/locale_provider.dart';
import 'package:uuid/uuid.dart';

class ItemModel {
  String? id;
  String name;
  String category;
  int quantity;
  String donorId;
  String details;
  String image;

  ItemModel(
      {this.id,
      required this.name,
      required this.category,
      required this.quantity,
        required this.donorId,
        required this.details,
      required this.image}){
    id??= const Uuid().v4();
  }

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'donorId': donorId,
      'details': details,
      'image': image,
    };
    return map;
  }
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      name: json["name"],
      category: json["category"],
      quantity: json["quantity"],
      donorId: json["donorId"],
      details: json["details"],
      image: json["image"],
    );
  }

  factory ItemModel.fromOb(Object ob) {
    return ob as ItemModel;
  }

  String print(LocaleProvider loc) {
    return '${loc.of(Tr.details)}: $details';
  }

  @override
  String toString() {
    return ' $name  $category $details';
  }
}
