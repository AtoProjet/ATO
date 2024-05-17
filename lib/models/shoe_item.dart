import 'package:ato/providers/locale_provider.dart';
import 'package:ato/models/item.dart';

class ShoeModel extends ItemModel{
  String size;
  String forGender;
  int color;
  ShoeModel(
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
  factory ShoeModel.fromJson(Map<String, dynamic> json) {
    return ShoeModel(
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

  factory ShoeModel.fromOb(Object ob) {
    return ob as ShoeModel;
  }

  @override
  String print(LocaleProvider loc) {
    return  '\n${super.print(loc)}'
        '\n${loc.of(Tr.size)}: $size'
        '\n${loc.of(Tr.forGender)}: ${loc.ofStr(forGender)}';
  }



  @override
  String toString() {
    return '${super.toString()} $size, $forGender ';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ShoeModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => super.hashCode ^ id.hashCode;

}
