import 'dart:convert' as js;

import 'package:almirabi/features/basic_data_management/car/data/car.dart';
import 'package:almirabi/features/basic_data_management/source_path/data/source_path_line.dart';

import '../../../../core/config/app_enums.dart';

class Requests {
  int? id;
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
      this.car,
      this.fromDate,
      this.driverId,
      this.toDate,
      this.monthName,
      this.sourcePathId,
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

        print(linsList.runtimeType);
        print("================lst.first.lins===================");
        print('linsList.runtimeType ${linsList.runtimeType}');
        print("================lst.first.lins===================");
      } else {
        linsList = [];
      }
    } else {
      linsList = [];
    }
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
    requestLines = [];
    for (var element in linsList) {
      requestLines!.add(SourcePathLine(
          destId: element['dest_id'],
          destName: element['dest_name'],
          destPrice: element['dest_price']));
    }

    driverId = json['driver_id'];
    amoutTotal = json['amout_total'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    print("toJson =============================");
    final Map<String, dynamic> data = <String, dynamic>{};
    List listId = [];
    if (isRemotelyAdded) {
      for (var element in requestLines!) {
        listId.add(element.destId);
      }
    }
    // print(requestLines);
    print(listId);
    data['id'] = id;
    data['product_car_id'] = car!.id;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['month_name'] = monthName;
    data['source_path_id'] = sourcePathId;
    data['source_path_name'] = sourcePathName;
    data['state'] = toState(state!);
    data['request_lines'] =
        isRemotelyAdded ? listId : js.json.encode(requestLines);
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
