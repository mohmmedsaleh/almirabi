import 'dart:convert';

import 'package:flutter/foundation.dart';

class Car {
  int? id;
  String? name;

  Car({this.id, this.name});

  Car.fromJson(Map<String, dynamic> json, {bool fromTemblet = false}) {
    id = json['car_id'];
    name = json['car_name'].toString();
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_id'] = id;
    data['car_name'] = name;
    return data;
  }
}
