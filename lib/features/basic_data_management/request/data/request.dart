import 'package:almirabi/features/basic_data_management/car/data/car.dart';

class Requests {
  int? id;
  Car? car;
  String? fromDate;
  String? toDate;
  String? monthName;
  int? sourcePathId;
  String? sourcePathName;
  String? state;
  List? requestLines;
  double? amoutTotal;
  Requests(
      {this.id,
      this.car,
      this.fromDate,
      this.toDate,
      this.monthName,
      this.sourcePathId,
      this.state,
      this.requestLines,
      this.amoutTotal});

  Requests.fromJson(Map<String, dynamic> json, {bool fromTemblet = false}) {
    print("${json['id']} ${json['id'].runtimeType}");
    print("${json['product_car_id']} ${json['product_car_id'].runtimeType}");
    print("${json['from_date']} ${json['from_date'].runtimeType}");
    print("${json['to_date']} ${json['to_date'].runtimeType}");
    print("${json['month_name']} ${json['month_name'].runtimeType}");
    print("${json['source_path_id']} ${json['source_path_id'].runtimeType}");
    print(
        "${json['source_path_name']} ${json['source_path_name'].runtimeType}");
    print("${json['state']} ${json['state'].runtimeType}");
    print("${json['request_lines']} ${json['request_lines'].runtimeType}");
    print("${json['amout_total']} ${json['amout_total'].runtimeType}");
    id = json['id'];
    car = Car(id: json['product_car_id'], name: '');
    fromDate = json['from_date'];
    toDate = json['to_date'];
    monthName = json['month_name'];
    sourcePathId = json['source_path_id'];
    sourcePathName = json['source_path_name'];
    state = json['state'];
    requestLines = json['request_lines'] ?? [];
    amoutTotal = json['amout_total'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['product_car_id'] = car!.id;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['month_name'] = monthName;
    data['source_path_id'] = sourcePathId;
    data['source_path_name'] = sourcePathName;
    data['state'] = state;
    data['request_lines'] = requestLines.toString();
    data['amout_total'] = amoutTotal;
    return data;
  }
}
