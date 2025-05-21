
// import '../../basic_data_management/order/data/order.dart';
// import '../data/basic_item_history.dart';
// import 'main_history_item_processor.dart';

// class ProductProcessor extends BasicItemProcessor<Product> {
//   final List<int> localIds;
//   ProductProcessor({required this.localIds});

//   @override
//   bool shouldInsert({required BasicItemHistory element, List<int>? posCategoryIds}) {
//     if(element.product == null) {
//       return false;
//     }
//     return (!localIds.contains(element.productId) && element.isAdded! && !element.isDeleted!)
//         ||(!localIds.contains(element.productId) && !element.isAdded! && !element.isDeleted! && posCategoryIds!.contains(element.product!.soPosCategId))
//         ||(!localIds.contains(element.productId) && element.isAdded! && element.isDeleted!);
//   }

//   @override
//   bool shouldUpdate({required BasicItemHistory element}) {
//     if(element.product == null) {
//       return false;
//     }
//     return (!element.isAdded! && !element.isDeleted!) ||
//         (localIds.contains(element.productId!) &&
//             element.isAdded! &&
//             !element.isDeleted!);
//   }

//   @override
//   bool shouldDelete({required BasicItemHistory element}) {
//     // if(element.product == null) {
//     //   return localIds.contains(element.productId) && element.isDeleted!;
//     // } else {
//     //   return localIds.contains(element.productId) && element.isDeleted! && element.isAdded!;
//     // }

//       return localIds.contains(element.productId) && element.isDeleted!;


//   }


//   @override
//   dynamic processElement({required BasicItemHistory element, bool isDelete = false}) {
//     return !isDelete ? element.product! : element.productId;
//   }
// }
