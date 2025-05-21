// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginInfo {
  String? visaNumber;
  String? pinNumber;
  LoginInfo({
    this.visaNumber,
    this.pinNumber,
  });

  LoginInfo.fromJson(Map<String, dynamic> json) {
    visaNumber = json['visa_no'] ?? '';
    pinNumber = json['pin_code'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visa_no'] = visaNumber;
    data['pin_code'] = pinNumber;
    return data;
  }
}
