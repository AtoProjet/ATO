class ItemModel {
  String id;
  String name;
  String categoryId;
  int quantity;
  String donorId;
  String details;
  String? image;

  ItemModel(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.quantity,
        required this.donorId,
        required this.details,
      this.image});

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'categoryId': categoryId,
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
      categoryId: json["categoryId"],
      quantity: json["quantity"],
      donorId: json["donorId"],
      details: json["details"],
      image: json["image"],
    );
  }

  factory ItemModel.fromOb(Object ob) {
    return ob as ItemModel;
  }
}
