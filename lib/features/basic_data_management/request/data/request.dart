import 'dart:convert' as js;

import 'package:almirabi/features/basic_data_management/car/data/car.dart';
import 'package:almirabi/features/basic_data_management/source_path/data/source_path_line.dart';

import '../../../../core/config/app_enums.dart';

class Requests {
  int? id;
  int? requestsId;
  Car? car;
  int? driverId;
  String? fromDate;
  String? toDate;
  String? monthName;
  int? sourcePathId;
  String? sourcePathName;
  RequestState? state;
  List<SourcePathLine>? requestLines;
  double? amoutTotal;

  Requests(
      {this.id,
      this.requestsId,
      this.car,
      this.fromDate,
      this.driverId,
      this.toDate,
      this.monthName,
      this.sourcePathId,
      this.sourcePathName,
      this.state,
      this.requestLines,
      this.amoutTotal});

  Requests.fromJson(Map<String, dynamic> json, {bool fromTemblet = false}) {
    var linsList = [];
    if (![null, false].contains(json['request_lines'])) {
      if (json['request_lines'] is List) {
        linsList = json['request_lines'];
      } else if (json['request_lines'] is String) {
        linsList =
            (js.json.decode(json['request_lines']) as List).cast<dynamic>();
      } else {
        linsList = [];
      }
    } else {
      linsList = [];
    }
    id = json['id'];
    requestsId = json['requests_id'];
    car = Car(
        id: json['product_car_id'] is List
            ? json['product_car_id'].first
            : json['product_car_id'],
        name: json['product_car_name'] ?? '');
    fromDate = json['from_date'];
    toDate = json['to_date'];
    monthName = json['month_name'] is int
        ? json['month_name'].toString()
        : json['month_name'];
    sourcePathId = json['source_path_id'] is List
        ? json['source_path_id'].first
        : json['source_path_id'];
    sourcePathName = json['source_path_name'];
    state = fromState(json['state'].toString());
    requestLines = [];
    for (var element in linsList) {
      requestLines!.add(SourcePathLine(
          destId:
              fromTemblet ? element['destination_path_id'] : element['dest_id'],
          destName: fromTemblet
              ? element['destination_path_name']
              : element['dest_name'],
          destPrice: fromTemblet ? element['price'] : element['dest_price']));
    }

    driverId =
        json['driver_id'] is List ? json['driver_id'].first : json['driver_id'];
    amoutTotal = json['amout_total'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    List listId = [];
    if (isRemotelyAdded) {
      for (var element in requestLines!) {
        listId.add(element.destId);
      }
    }
    // print(requestLines);
    // data['id'] = id;
    data['product_car_id'] = car!.id;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['month_name'] = '05';
    data['source_path_id'] = sourcePathId;
    if (!isRemotelyAdded) {
      data['source_path_name'] = sourcePathName;
      data['requests_id'] = requestsId;
    }
    data['state'] = toState(state!);
    data['request_lines'] =
        // isRemotelyAdded ? listId :
        js.json.encode(requestLines);
    data['driver_id'] = driverId;
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
