import 'package:almirabi/features/basic_data_management/car/data/car.dart';
import 'package:almirabi/features/basic_data_management/source_path/data/source_path_line.dart';

class SourcePath {
  int? sourcePathId;
  String? sourcePathName;
  List<SourcePathLine>? lins;

  SourcePath({
    this.sourcePathId,
    this.sourcePathName,
    this.lins,
  });

  SourcePath.fromJson(Map<String, dynamic> json, {bool fromTemblet = false}) {
    List linsList =
        ![null, false].contains(json['lines']) && json['lines'] is List
            ? json['lines']
            : [];

    sourcePathId = json['source_path_id'];
    sourcePathName = json['source_path_name'];
    lins = [];
    linsList.forEach(
      (element) {
        lins!.add(SourcePathLine(
            destId: element['dest_id'],
            destName: element['dest_name'],
            destPrice: element['dest_price']));
      },
    );
    json['from_date'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['source_path_id'] = sourcePathId;
    data['source_path_name'] = sourcePathName;
    data['lines'] = lins.toString();
    return data;
  }
}
