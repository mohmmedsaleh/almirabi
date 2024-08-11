import 'package:almirabi/features/authentication/presentation/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_enums.dart';
import '../../../core/config/app_shared_pr.dart';
import '../../../core/config/app_styles.dart';

import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_snack_bar.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../core/shared_widgets/custom_app_bar.dart';
import '../domain/remote_database_setting_viewmodel.dart';

class RemoteDatabaseScreen extends StatefulWidget {
  final bool changeConnectionInfo;

  const RemoteDatabaseScreen({super.key, this.changeConnectionInfo = false});

  @override
  State<RemoteDatabaseScreen> createState() => _RemoteDatabaseScreenState();
}

class _RemoteDatabaseScreenState extends State<RemoteDatabaseScreen> {
  DatabaseSettingController remoteDatabaseSettingController =
      Get.put(DatabaseSettingController.getInstance());
  TextEditingController dbNameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  final keyFocusNode = FocusNode();
  final _buttonFocusNode = FocusNode();
  bool flag = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      keyFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "ابي",
                          style: TextStyle(
                              fontSize: Get.width * 0.1,
                              fontWeight: FontWeight.w100,
                              color: AppColor.grey),
                        ),
                        Text("")
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "المير",
                          style: TextStyle(
                              fontSize: Get.width * 0.1,
                              fontWeight: FontWeight.w900,
                              color: AppColor.brawn),
                        ),
                        Text(
                          "Almirabi",
                          style: TextStyle(
                              fontSize: Get.width * 0.03,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'remote_connection_information'.tr,
                              style: TextStyle(
                                  fontSize: Get.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Text(
                        'dbName'.tr,
                        style: TextStyle(
                            fontSize: Get.width * 0.03,
                            fontWeight: FontWeight.bold,
                            color: AppColor.black),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      ContainerTextField(
                        controller: dbNameController,
                        prefixIcon: Icons.person,
                        hintText: 'dbName'.tr,
                        labelText: 'dbName'.tr,
                        width: Get.width,
                        height: MediaQuery.sizeOf(context).height * 0.05,
                        hintcolor: AppColor.black.withOpacity(0.5),
                        iconcolor: AppColor.black,
                        color: AppColor.black,
                        fontSize: Get.width * 0.03,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            errorMessage = 'required_message'
                                .trParams({'field_name': 'dbName'.tr});

                            return "";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02),
                      Text(
                        'url'.tr,
                        style: TextStyle(
                            fontSize: Get.width * 0.03,
                            fontWeight: FontWeight.bold,
                            color: AppColor.black),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      ContainerTextField(
                        controller: urlController,
                        prefixIcon: Icons.key,
                        hintText: 'url'.tr,
                        labelText: 'url'.tr,
                        obscureText: flag ? false : true,
                        width: Get.width,
                        height: MediaQuery.sizeOf(context).height * 0.05,
                        hintcolor: AppColor.black.withOpacity(0.5),
                        iconcolor: AppColor.black,
                        color: AppColor.black,
                        fontSize: Get.width * 0.03,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  flag = !flag;
                                });
                              },
                              icon: flag
                                  ? Icon(
                                      Icons.visibility,
                                      color: AppColor.black,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: AppColor.black,
                                    )),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            errorMessage = 'required_message_f'
                                .trParams({'field_name': 'url'.tr});
                            return "";
                          }
                          // if (value.isNotEmpty) {
                          //   var message = ValidatorHelper.passWordValidation(value: value);
                          //   if (message == "") {
                          //     return null;
                          //   }
                          //   errorMessage = message;
                          //   return "";
                          // }
                          return null;
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.04),
                      Obx(() {
                        if (remoteDatabaseSettingController.isLoading.value) {
                          return CircularProgressIndicator(
                            color: AppColor.white,
                            backgroundColor: AppColor.black,
                          );
                        } else {
                          return Row(
                            children: [
                              Expanded(
                                child: ButtonElevated(
                                    borderRadius: 20,
                                    text: 'connect'.tr,
                                    backgroundColor: AppColor.brawn,
                                    onPressed: _onPressed),
                              ),
                              if (widget.changeConnectionInfo)
                                const SizedBox(
                                  width: 20,
                                ),
                              if (widget.changeConnectionInfo)
                                Expanded(
                                  child: ButtonElevated(
                                      text: 'back'.tr,
                                      borderRadius: 20,
                                      borderColor: AppColor.brawn,
                                      onPressed: () async {
                                        Get.back();
                                      }),
                                ),
                            ],
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onPressed() {
    if (_formKey.currentState!.validate()) {
      remoteDatabaseSettingController.checkDatabase("").then((value) async {
        if (value.status) {
          appSnackBar(
            messageType: MessageTypes.success,
            message: 'success_key_login'.tr,
          );
          await SharedPr.removeUserObj();
          // Get.to(() => const EmployeesListScreen());
          Get.to(() => const LoginScreen());
        } else {
          appSnackBar(
            message: value.message!,
          );
        }
      });
    } else {
      appSnackBar(
        message: errorMessage!,
      );
    }
  }
}
