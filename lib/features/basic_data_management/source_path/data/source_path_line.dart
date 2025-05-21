class SourcePathLine {
  int? destId;
  String? destName;
  double? destPrice;
  int? quantity;
  double? destTotalPrice;

  SourcePathLine({
    this.destId,
    this.destName,
    this.quantity,
    this.destPrice,
    this.destTotalPrice,
  });

  SourcePathLine.fromJson(Map<String, dynamic> json,
      {bool fromTemblet = false}) {
    destId = fromTemblet ? json['destination_path_id'] : json['dest_id'];
    destName = fromTemblet ? json['destination_path_name'] : json['dest_name'];
    destPrice = fromTemblet ? json['price'] : json['dest_price'];
    quantity = fromTemblet ? json['quantity'] : json['quantity'];
    destTotalPrice = fromTemblet ? json['total'] : json['dest_total_price'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['dest_id'] = destId;
    data['dest_name'] = destName;
    data['dest_price'] = destPrice;
    data['quantity'] = quantity;
    if (!isRemotelyAdded) {
      data['dest_total_price'] = destTotalPrice;
    }
    return data;
  }
}
