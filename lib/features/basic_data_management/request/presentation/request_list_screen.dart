import 'package:almirabi/core/shared_widgets/custom_app_bar.dart';
import 'package:almirabi/features/basic_data_management/request/domain/request_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/shared_widgets/app_button.dart';
import '../../../../core/shared_widgets/app_custombackgrond.dart';
import '../../../../core/shared_widgets/app_text_field.dart';
import '../../../loading_synchronizing_data/domain/loading_synchronizing_data_viewmodel.dart';
import '../../utils/filtter_request.dart';
import '../domain/request_service.dart';

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
  LoadingDataController loadingDataController =
      Get.put(LoadingDataController());
  late final RequestController requestController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('======initState===========');
    requestController = Get.put(RequestController());
    RequestService.requestDataServiceInstance = null;
    RequestService.getInstance();
    getPagingList();
  }

  @override
  void dispose() {
    requestController.searchResults.clear();
    super.dispose();
  }

  Future getPagingList() async {
    print('========================');
    await requestController.displayRequestList(paging: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(headerBackground: true),
        body: CustomBackGround(
          child: GetBuilder<RequestController>(builder: (controller) {
            print(requestController.requestList.length);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonElevated(
                            width: Get.width / 4,
                            text: 'add'.tr,
                            backgroundColor: AppColor.brawn,
                            iconData: Icons.add,
                            borderRadius: 25),
                      ),
                      ContainerTextField(
                        readOnly: true,
                        hintcolor: AppColor.white,
                        width: (Get.width / 4) * 2,
                        height: MediaQuery.sizeOf(context).height * 0.05,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.white,
                        ),
                        suffixIcon: Builder(builder: (iconContext) {
                          return IconButton(
                              onPressed: () async {
                                filtterRequestByState(
                                    context: iconContext,
                                    requests: requestController.requestList,
                                    requestController: requestController);
                              },
                              icon: Icon(
                                Icons.filter_alt_sharp,
                                color: AppColor.white,
                              ));
                        }),
                        isPIN: true,
                        isAddOrEdit: true,
                        borderColor: AppColor.white,
                        labelText: 'filtter_by'.tr,
                        hintText: 'filtter_by'.tr,
                        iconcolor: AppColor.white,
                        color: AppColor.white,
                        borderRadius: 50,
                        fontSize: Get.width * 0.03,
                        maxLength: 20,
                        controller: requestController.searchProductController,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Wrap(
                    children: [
                      ...requestController.requestList.map((item) => Container(
                            width: Get.width * 0.45,
                            height: 100,
                            margin: EdgeInsets.all(5),
                            color: AppColor.brawn,
                          ))
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
