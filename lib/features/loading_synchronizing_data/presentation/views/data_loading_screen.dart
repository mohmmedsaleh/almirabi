import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/app_colors.dart';
import '../../../basic_data_management/request/presentation/view/request_list_screen.dart';
import '../../domain/loading_synchronizing_data_viewmodel.dart';

class DataLoadingScreen extends StatefulWidget {
  const DataLoadingScreen({super.key});

  @override
  State<DataLoadingScreen> createState() => _DataLoadingScreenState();
}

class _DataLoadingScreenState extends State<DataLoadingScreen> {
  late LoadingDataController loadingDataController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingDataController = Get.put(LoadingDataController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoadingDataController>(builder: (controller) {
        return controller.isLoading.value
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColor.brawn,
                      backgroundColor: AppColor.black,
                    ),
                    Text('data_isloading'.tr)
                  ],
                ),
              )
            : Container();
      }),
    );
  }
}
