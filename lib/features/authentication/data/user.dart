class User {
  int? id;
  String? name;
  String? image_1920;

  User({
    this.id,
    this.name,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['driver_id'];
    name = json['driver_name'];
    image_1920 = json['image'] == false ? '' : json['image'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driver_id'] = id;
    data['driver_name'] = name;
    data['image'] = image_1920;
    return data;
  }
}
