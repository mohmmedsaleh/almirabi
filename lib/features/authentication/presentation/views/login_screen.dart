import 'package:almirabi/core/shared_widgets/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_enums.dart';
import '../../../../core/shared_widgets/app_button.dart';
import '../../../../core/shared_widgets/app_custom_icon.dart';
import '../../../../core/shared_widgets/app_snack_bar.dart';
import '../../../../core/shared_widgets/app_text_field.dart';
import '../../../../core/utils/response_result.dart';
import '../../../basic_data_management/request/presentation/request_list_screen.dart';
import '../../data/login_info.dart';
import '../../domain/authentication_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController visaNumberController = TextEditingController();
  TextEditingController pinNumberController = TextEditingController();
  AuthenticationController authenticationController =
      Get.put(AuthenticationController.getInstance());
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  int countErrors = 0;
  bool flag = false;
  final _buttonFocusNode = FocusNode();
  var userNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    userNameFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      //print(SharedPr.isForgetPass!);
    }

    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "ابي",
                              style: TextStyle(
                                  fontSize: Get.width * 0.15,
                                  fontWeight: FontWeight.w100,
                                  color: AppColor.grey),
                            ),
                            const Text("")
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "المير",
                              style: TextStyle(
                                  fontSize: Get.width * 0.15,
                                  fontWeight: FontWeight.w900,
                                  color: AppColor.brawn),
                            ),
                            Text(
                              "Almirabi",
                              style: TextStyle(
                                  fontSize: Get.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                'login'.tr,
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
                          'visa_number'.tr,
                          style: TextStyle(
                              fontSize: Get.width * 0.03,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        ContainerTextField(
                          controller: visaNumberController,
                          prefixIcon: const CustomIcon(
                              size: 5, assetPath: 'assets/images/passport.png'),
                          hintText: 'visa_number'.tr,
                          labelText: 'visa_number'.tr,
                          width: Get.width,
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          hintcolor: AppColor.black.withOpacity(0.5),
                          iconcolor: AppColor.black,
                          color: AppColor.black,
                          fontSize: Get.width * 0.03,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              errorMessage = 'required_message'
                                  .trParams({'field_name': 'username'.tr});
                              countErrors++;
                              return "";
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02),
                        Text(
                          'pin_number'.tr,
                          style: TextStyle(
                              fontSize: Get.width * 0.03,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        ContainerTextField(
                          keyboardType: TextInputType.number,
                          controller: pinNumberController,
                          prefixIcon: const CustomIcon(
                              size: 5, assetPath: 'assets/images/key.png'),
                          hintText: 'pin_number'.tr,
                          labelText: 'pin_number'.tr,
                          obscureText: flag ? false : true,
                          width: Get.width,
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          hintcolor: AppColor.black.withOpacity(0.5),
                          iconcolor: AppColor.black,
                          color: AppColor.black,
                          fontSize: Get.width * 0.03,
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
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
                                  .trParams({'field_name': 'pin_number'.tr});
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
                          if (authenticationController.loading.value) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColor.white,
                                backgroundColor: AppColor.black,
                              ),
                            );
                          } else {
                            return ButtonElevated(
                                borderRadius: 20,
                                text: 'login'.tr,
                                width: Get.width,
                                backgroundColor: AppColor.brawn,
                                onPressed: onPressed);
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
      ),
    );
  }

  onPressed() async {
    // if (usernameController.text != SharedPr.chosenUserObj!.userName) {

    // appSnackBar(
    //     message:
    //         'user_does_not_match'.trParams({'field_name': 'username'.tr}));
    // return;
    // }

    countErrors = 0;
    if (_formKey.currentState!.validate()) {
      // print("validate true");

      ResponseResult responseResult = await authenticationController
          .authenticateUsingUsernameAndPassword(LoginInfo(
              visaNumber: visaNumberController.text,
              pinNumber: pinNumberController.text));
      if (responseResult.status) {
        Get.to(() => const RequestListScreen());

        // Get.to(() => const DashboardScreen());
        appSnackBar(
          messageType: MessageTypes.success,
          message: responseResult.message,
        );
      } else {
        appSnackBar(
          message: responseResult.message,
        );
        return;
      }
    } else {
      // print("countErrors $countErrors");
      appSnackBar(
        message: countErrors > 1 ? 'enter_required_info'.tr : errorMessage!,
      );
    }
  }
}
