import 'package:ato/models/cloth_item.dart';
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

  String searchData() {
    String search = ' $name $category $details ';
    if(this is ClothModel){
      ClothModel clothModel= this as ClothModel;
      search += " ${clothModel.size}  ${clothModel.forGender} ";
    }
    return search.toLowerCase();
  }



  @override
  String toString() {
    return ' $name  $category $details';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
