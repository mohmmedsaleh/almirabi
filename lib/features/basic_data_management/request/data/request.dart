import 'package:almirabi/features/basic_data_management/car/data/car.dart';

class Requests {
  int? id;
  Car? car;
  int? fromDate;
  int? toDate;
  int? monthName;
  String? sourcePathId;
  int? state;
  String? requestLines;
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
    car = Car(
        id: json['product_car_id'].first,
        productId: 0,
        image: '',
        name: json['product_car_id'].last);
    fromDate = json['from_date'];
    toDate = json['to_date'];
    monthName = json['month_name'];
    sourcePathId = json['source_path_id'];
    state = json['state'];
    requestLines = json['request_lines'];
    amoutTotal = json['amout_total'];
  }

  Map<String, dynamic> toJson({bool isRemotelyAdded = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};

    // if(toLocal){
    //   data['list_price'] = unitPrice;
    //   return data;
    // }
    data['id'] = id;
    data['product_tmpl_id'] = productTmplId;
    data['product_id'] = productId;
    data['uom_id'] = uomId;
    // data['uom_name'] = uomName;
    data['default_code'] = defaultCode;
    data['so_pos_categ_id'] = soPosCategId;
    // data['so_pos_categ_name'] = soPosCategName;
    data['barcode'] = barcode;
    data['unit_price'] = unitPrice;
    data['currency'] = currency;
    data['image'] = image;
    data[]
    return data;
  }

  Map<String, dynamic> remoteInsertWithSpecificMap({bool update = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['list_price'] = unitPrice;
    data['detailed_type'] = "product";
    data['barcode'] = barcode;
    data['so_pos_categ_id'] = soPosCategId;
    data['uom_id'] = uomId; // unit_uom_id
    data['uom_po_id'] = uomId; // purchase_uom_id
    data['pos_available'] = true;
    data['image_1920'] = image;
    return data;
  }
}
