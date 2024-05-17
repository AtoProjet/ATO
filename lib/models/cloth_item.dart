import 'package:ato/providers/locale_provider.dart';
import 'package:ato/models/item.dart';

class ClothModel extends ItemModel{
  String size;
  String forGender;
  int color;
  ClothModel(
      {super.id, required super.name, required super.category, required super.quantity, required super.donorId, required super.details,
        required super.image,
        required this.size,
        required this.forGender,
        required this.color,
      });

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "category": category,
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
      category: json["category"],
    );
  }

  factory ClothModel.fromOb(Object ob) {
    return ob as ClothModel;
  }

  @override
  String print(LocaleProvider loc) {
    return  '\n${super.print(loc)}'
        '\n${loc.of(Tr.size)}: $size'
        '\n${loc.of(Tr.forGender)}: ${loc.ofStr(forGender)}';
  }



  @override
  String toString() {
    //return ' $name';

    return '${super.toString()} $size , $forGender ';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ClothModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => super.hashCode ^ id.hashCode;

}
