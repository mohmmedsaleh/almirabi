import 'dart:convert' as js;

import 'package:almirabi/features/basic_data_management/source_path/data/source_path_line.dart';

import '../../car/data/car.dart';

class SourcePath {
  int? sourcePathId;
  String? sourcePathName;
  Car? car;
  List<SourcePathLine>? lins;

  SourcePath({
    this.sourcePathId,
    this.sourcePathName,
    this.car,
    this.lins,
  });

  SourcePath.fromJson(Map<String, dynamic> json, {bool fromTemblet = false}) {
    var linsList = [];
    if (![null, false].contains(json['lines'])) {
      if (json['lines'] is List) {
        linsList = json['lines'];
      } else if (json['lines'] is String) {
        linsList = (js.json.decode(json['lines']) as List).cast<dynamic>();
      } else {
        linsList = [];
      }
    } else {
      linsList = [];
    }
    sourcePathId = json['source_path_id'];
    sourcePathName = json['source_path_name'];
    car = Car(id: json['product_car_id'], name: json['product_car_name']);
    lins = [];
    for (var element in linsList) {
      lins!.add(SourcePathLine(
          destId: element['dest_id'],
          destName: element['dest_name'],
          destPrice: element['dest_price']));
    }
    json['from_date'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['source_path_id'] = sourcePathId;
    data['source_path_name'] = sourcePathName;
    data['product_car_id'] = car!.id;
    data['lines'] = js.json.encode(lins);

    return data;
  }
}
