// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginInfo {
  String? userName;
  String? password;
  String? db;
  String? url;
  String? pinCode;
  LoginInfo({
    this.userName,
    this.password,
    this.db,
    this.url,
    this.pinCode,
  });

  LoginInfo.fromJson(Map<String, dynamic> json) {
    userName = json['user_name']??'';
    password = json['password'] == '' ? null : json['password'];
    db = json['db'];
    url = json['url'];
    pinCode = json['pin_code']?? '';
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['password'] = password;
    data['db'] = db;
    data['url'] = url;
    data['pin_code'] = pinCode;
    return data;
  }
}
