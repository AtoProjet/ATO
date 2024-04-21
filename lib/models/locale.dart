class LocaleModel {
  String name;
  LocaleModel(
      {
        required this.name
      });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
    };
    return map;
  }
  factory LocaleModel.fromJson(Map<String, dynamic> json) {
    return LocaleModel(
      name: json["name"],
    );
  }

  factory LocaleModel.fromOb(Object ob) {
    return ob as LocaleModel;
  }
}
