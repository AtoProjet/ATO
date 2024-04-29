import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class OrderModel {
  String? id;
  String beneficiaryId;
  Map<String, int> pickedItems;
  FieldValue? time;
  String deliveryDate;
  String deliveryTime;
  OrderModel({
    this.id,
    required this.beneficiaryId,
    required this.pickedItems,
    this.time,
    required this.deliveryDate,
    required this.deliveryTime,
  }) {
    time ??= FieldValue.serverTimestamp();
    id ??= const Uuid().v4().toString();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'beneficiaryId': beneficiaryId,
      'pickedItems': pickedItems,
      'time': time,
      'deliveryDate': deliveryDate,
      'deliveryTime': deliveryTime,
    };
    return map;
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      beneficiaryId: json["beneficiaryId"],
      pickedItems: json["pickedItems"],
      time: json["time"],
      deliveryDate: json["deliveryDate"],
      deliveryTime: json["deliveryTime"],
    );
  }

  factory OrderModel.fromOb(Object ob) {
    return ob as OrderModel;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
