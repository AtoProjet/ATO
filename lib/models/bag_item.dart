import 'package:ato/providers/locale_provider.dart';
import 'package:ato/models/item.dart';

class BagModel extends ItemModel{
  int color;
  BagModel(
      {super.id, required super.name, required super.category, required super.quantity, required super.donorId, required super.details,
        required super.image,
        required this.color,
      });

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "category": category,
      'color': color,
      'quantity': quantity,
      'donorId': donorId,
      'details': details,
      'image': image,
    };
    return map;
  }
  factory BagModel.fromJson(Map<String, dynamic> json) {
    return BagModel(
      color: json["color"],
      quantity: json["quantity"],
      donorId: json["donorId"],
      details: json["details"],
      image: json["image"],
      id: json["id"],
      name: json["name"],
      category: json["category"],
    );
  }

  factory BagModel.fromOb(Object ob) {
    return ob as BagModel;
  }

  @override
  String print(LocaleProvider loc) {
    return  '\n${super.print(loc)}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is BagModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => super.hashCode ^ id.hashCode;

}
