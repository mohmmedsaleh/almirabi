import 'dart:convert';

import 'package:flutter/foundation.dart';

class Car {
  int? id;

  int? productId;
  String? name;
  String? image;

  Car({this.id, this.productId, this.image, this.name});

  Car.fromJson(Map<String, dynamic> json, {bool fromTemblet = false}) {
    print(json);
    print(json['id'].runtimeType);
    print(json['name'].runtimeType);
    id = json['id'];
    productId = json['product_id'] ?? 0;
    name = json['name'].toString();
    image =
        [null, false].contains(json['image_1920']) ? null : json['image_1920'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};

    // if(toLocal){
    //   data['list_price'] = unitPrice;
    //   return data;
    // }
    data['id'] = id;
    data['product_id'] = productId;

    data['name'] = name;

    data['image'] = image;
    return data;
  }
}
