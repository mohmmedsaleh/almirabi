import 'package:almirabi/core/shared_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/shared_widgets/app_button.dart';
import '../../../loading_synchronizing_data/domain/loading_synchronizing_data_viewmodel.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   LoadingDataController loadingDataController =
//       Get.put(LoadingDataController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:
//         Center(
//             child: Container(
//       child: ButtonElevated(
//           onPressed: () {
//             Get.back();
//           },
//           text: 'ddddd'),
//     )));
//   }
// }
class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(headerBackground: true),
        body: Container(),
      ),
    );
  }
}
