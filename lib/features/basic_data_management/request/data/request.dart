import 'dart:convert';

import 'package:almirabi/features/basic_data_management/car/data/car.dart';

import '../../../../core/config/app_enums.dart';

class Requests {
  int? id;
  Car? car;
  String? fromDate;
  String? toDate;
  String? monthName;
  int? sourcePathId;
  String? sourcePathName;
  RequestState? state;
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
    id = json['id'];
    car = Car(id: json['product_car_id'], name: '');
    fromDate = json['from_date'];
    toDate = json['to_date'];
    monthName = json['month_name'] is int
        ? json['month_name'].toString()
        : json['month_name'];
    sourcePathId = json['source_path_id'];
    sourcePathName = json['source_path_name'];
    state = fromState(json['state'].toString());
    requestLines =
        json['request_lines'] != null ? jsonDecode(json['request_lines']) : [];
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
    data['state'] = toState(state!);
    data['request_lines'] = requestLines.toString();
    data['amout_total'] = amoutTotal;
    return data;
  }

  RequestState fromState(String string) {
    RequestState? resultState;
    switch (string) {
      case "draft":
        resultState = RequestState.draft;
        break;
      case "closed":
        resultState = RequestState.closed;
        break;
      case "confirm":
        resultState = RequestState.confirm;
        break;
      case "cancel":
        resultState = RequestState.cancel;
        break;
      default:
    }
    return resultState!;
  }

  String toState(RequestState requestState) {
    String? resultState;
    switch (requestState) {
      case RequestState.draft:
        resultState = "draft";
        break;
      case RequestState.closed:
        resultState = "closed";
        break;
      case RequestState.confirm:
        resultState = "confirm";
        break;
      case RequestState.cancel:
        resultState = "cancel";
        break;
      default:
    }
    return resultState!;
  }
}
