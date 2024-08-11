import 'package:almirabi/features/basic_data_management/car/data/car.dart';

class SourcePathLine {
  int? destId;
  String? destName;
  double? destPrice;

  SourcePathLine({
    this.destId,
    this.destName,
    this.destPrice,
  });

  SourcePathLine.fromJson(Map<String, dynamic> json,
      {bool fromTemblet = false}) {
    destId = json['dest_id'];
    destName = json['dest_name'];
    destPrice = json['dest_price'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['dest_id'] = destId;
    data['dest_name'] = destName;
    data['dest_price'] = destPrice;
    return data;
  }
}
