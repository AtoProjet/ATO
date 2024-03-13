class UserModel {
  String id;
  String name;
  String email;
  String? phone;
  String? role;
  String? image;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      this.phone,
      this.role,
      this.image}
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'image': image,
    };
    return map;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      role: json["role"],
      image: json["image"],
    );
  }

  factory UserModel.fromOb(Object ob) {
    return ob as UserModel;
  }
}
