class SubscriptionInfo {
  String? db;
  String? url;

  SubscriptionInfo({
    required this.url,
    required this.db,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['dbname'] = db;
    json['url_link'] = url;
    return json;
  }

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    return SubscriptionInfo(
      db: json['dbname'],
      url: json['url_link'],
    );
  }
}
