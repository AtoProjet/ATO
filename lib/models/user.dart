class UserModel {
  static UserModel? user;

  String id;
  String name;
  String email;
  String phone;
  String birthDate;
  String area;
  String role;
  String? image;
  bool isActive;
  bool isDeleted;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
        required this.birthDate,
        required this.area,
      required this.role,
      required this.isActive,
      required this.isDeleted,
      this.image});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'birthDate': birthDate,
      'area': area,
      'role': role,
      'image': image,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
    return map;
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      birthDate: json["birthDate"],
      area: json["area"],
      role: json["role"],
      image: json["image"],
      isActive: json["isActive"],
      isDeleted: json["isDeleted"],
    );
  }

  factory UserModel.fromOb(Object ob) {
    return ob as UserModel;
  }
}
