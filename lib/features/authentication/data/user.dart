import 'dart:convert' as js;

import 'package:almirabi/features/basic_data_management/car/data/car.dart';

import '../../basic_data_management/source_path/data/source_path.dart';
import '../../basic_data_management/source_path/data/source_path_line.dart';

class User {
  int? id;
  String? name;
  String? image_1920;
  SourcePath? sourcePath;

  User({this.id, this.name, this.image_1920, this.sourcePath});

  User.fromJson(Map<String, dynamic> json) {
    var linsList = [];
    if (![null, false].contains(json['lines'])) {
      if (json['lines'] is List) {
        linsList = json['lines'];
      } else if (json['lines'] is String) {
        print(json['lines']);
        linsList = (js.json.decode(json['lines']) as List).cast<dynamic>();
        print('linsList==========> $linsList');
      } else {
        linsList = [];
      }
    } else {
      linsList = [];
    }
    List<SourcePathLine>? lins = [];
    for (var element in linsList) {
      lins.add(SourcePathLine(
          destId: element['dest_id'],
          destName: element['dest_name'],
          destPrice: element['dest_price']));
    }

    id = json['driver_id'];
    name = json['driver_name'];
    sourcePath = SourcePath(
      sourcePathId: json['source_path_id'] ?? 0,
      sourcePathName: json['source_path_name'] ?? '',
      car: Car(id: json['car_id'] ?? 0, name: json['car_name'] ?? ''),
      lins: lins,
    );
    image_1920 = json['image'] == false ? '' : json['image'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driver_id'] = id;
    data['driver_name'] = name;
    data['source_path_id'] = sourcePath!.sourcePathId;
    data['source_path_name'] = sourcePath!.sourcePathName;
    data['car_id'] = sourcePath!.car!.id;
    data['car_name'] = sourcePath!.car!.name;
    data['lines'] = js.json.encode(sourcePath!.lins);
    data['image'] = image_1920;
    return data;
  }
}
