class User {
  int? id;
  String? name;
  String? image_1920;
  String? userName;
  String? password;
  String? pinCode;
  int? pinCodeLock;
  int? accountLock;
  List<int>? posConfigIds;

  User({
    this.id,
    this.name,
    this.pinCode,
    this.pinCodeLock,
    this.accountLock,
    this.userName,
    this.password,
    this.image_1920,
    this.posConfigIds,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['login'];
    password = json['password'] == '' ? null : json['password'];
    pinCodeLock = json['pin_code_lock'];
    accountLock = json['account_lock'];
    pinCode = json['pin_code'] == false ? null : json['pin_code'];
    image_1920 = json['image_1920'] == false ? '' : json['image_1920'];
    posConfigIds = json['pos_config_ids'] == null
        ? []
        : json['pos_config_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['login'] = userName;
    data['password'] = password;
    data['pin_code'] = pinCode;
    data['pin_code_lock'] = pinCodeLock;
    data['account_lock'] = accountLock;
    data['image_1920'] = image_1920;
    data['pos_config_ids'] = posConfigIds;
    return data;
  }
}
