import 'package:almirabi/core/config/app_urls.dart';
import 'package:almirabi/features/authentication/presentation/views/login_screen.dart';
import 'package:almirabi/features/remote_database_setting/data/subscription_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_package/features/remote_database_setting/domain/remote_database_setting_service.dart';
import 'package:pos_package/features/remote_database_setting/domain/remote_database_setting_viewmodel.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_enums.dart';
import '../../../core/config/app_shared_pr.dart';
import 'package:pos_package/core/config/app_shared_pr.dart' as SharedPrPackage;
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_custom_icon.dart';
import '../../../core/shared_widgets/app_header_icons.dart';
import '../../../core/shared_widgets/app_snack_bar.dart';
import '../../../core/shared_widgets/app_text_field.dart';

// class RemoteDatabaseScreen extends StatefulWidget {
//   final bool changeConnectionInfo;
//   final SubscriptionInfo? subscriptionInfo;

//   const RemoteDatabaseScreen(
//       {super.key, this.changeConnectionInfo = false, this.subscriptionInfo});

//   @override
//   State<RemoteDatabaseScreen> createState() => _RemoteDatabaseScreenState();
// }

// class _RemoteDatabaseScreenState extends State<RemoteDatabaseScreen> {
//   DatabaseSettingController remoteDatabaseSettingController =
//       Get.put(DatabaseSettingController.getInstance());
//   TextEditingController dbNameController = TextEditingController();
//   TextEditingController urlController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   String? errorMessage;
//   final keyFocusNode = FocusNode();
//   final _buttonFocusNode = FocusNode();
//   bool flag = false;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.changeConnectionInfo) {
//       dbNameController.text = widget.subscriptionInfo!.db!;
//       urlController.text = widget.subscriptionInfo!.url!;
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       keyFocusNode.requestFocus();
//     });
//   }

//   @override
//   void dispose() {
//     _buttonFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: customAppBar(),
//         body: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Column(
//                           children: [
//                             Text(
//                               "ابي",
//                               style: TextStyle(
//                                   fontSize: Get.width * 0.1,
//                                   fontWeight: FontWeight.w100,
//                                   color: AppColor.grey),
//                             ),
//                             const Text("")
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               "المير",
//                               style: TextStyle(
//                                   fontSize: Get.width * 0.1,
//                                   fontWeight: FontWeight.w900,
//                                   color: AppColor.brawn),
//                             ),
//                             Text(
//                               "Almirabi",
//                               style: TextStyle(
//                                   fontSize: Get.width * 0.03,
//                                   fontWeight: FontWeight.bold,
//                                   color: AppColor.black),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: Get.height * 0.02),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'remote_connection_information'.tr,
//                                 style: TextStyle(
//                                     fontSize: Get.width * 0.05,
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColor.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: Get.height * 0.02),
//                         Text(
//                           'dbName'.tr,
//                           style: TextStyle(
//                               fontSize: Get.width * 0.03,
//                               fontWeight: FontWeight.bold,
//                               color: AppColor.black),
//                         ),
//                         SizedBox(height: Get.height * 0.01),
//                         ContainerTextField(
//                           controller: dbNameController,
//                           prefixIcon: CustomIcon(
//                               size: Get.width * 0.05,
//                               assetPath: 'assets/images/database-storage.png'),
//                           hintText: 'dbName'.tr,
//                           labelText: 'dbName'.tr,
//                           width: Get.width,
//                           height: MediaQuery.sizeOf(context).height * 0.05,
//                           hintcolor: AppColor.black.withOpacity(0.5),
//                           iconcolor: AppColor.black,
//                           color: AppColor.black,
//                           fontSize: Get.width * 0.03,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               errorMessage = 'required_message'
//                                   .trParams({'field_name': 'dbName'.tr});

//                               return "";
//                             }

//                             return null;
//                           },
//                         ),
//                         SizedBox(
//                             height: MediaQuery.sizeOf(context).height * 0.02),
//                         Text(
//                           'url'.tr,
//                           style: TextStyle(
//                               fontSize: Get.width * 0.03,
//                               fontWeight: FontWeight.bold,
//                               color: AppColor.black),
//                         ),
//                         SizedBox(height: Get.height * 0.01),
//                         ContainerTextField(
//                           controller: urlController,
//                           prefixIcon: Icon(
//                             Icons.http_outlined,
//                             color: AppColor.black,
//                           ),
//                           hintText: 'url'.tr,
//                           labelText: 'url'.tr,
//                           width: Get.width,
//                           height: MediaQuery.sizeOf(context).height * 0.05,
//                           hintcolor: AppColor.black.withOpacity(0.5),
//                           iconcolor: AppColor.black,
//                           color: AppColor.black,
//                           fontSize: Get.width * 0.03,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               errorMessage = 'required_message_f'
//                                   .trParams({'field_name': 'url'.tr});
//                               return "";
//                             }
//                             // if (value.isNotEmpty) {
//                             //   var message = ValidatorHelper.passWordValidation(value: value);
//                             //   if (message == "") {
//                             //     return null;
//                             //   }
//                             //   errorMessage = message;
//                             //   return "";
//                             // }
//                             return null;
//                           },
//                         ),
//                         SizedBox(
//                             height: MediaQuery.sizeOf(context).height * 0.04),
//                         Obx(() {
//                           if (remoteDatabaseSettingController.isLoading.value) {
//                             return Center(
//                               child: CircularProgressIndicator(
//                                 color: AppColor.white,
//                                 backgroundColor: AppColor.black,
//                               ),
//                             );
//                           } else {
//                             return Row(
//                               children: [
//                                 Expanded(
//                                   child: ButtonElevated(
//                                       borderRadius: 20,
//                                       text: 'connect'.tr,
//                                       backgroundColor: AppColor.brawn,
//                                       onPressed: _onPressed),
//                                 ),
//                                 if (widget.changeConnectionInfo)
//                                   const SizedBox(
//                                     width: 20,
//                                   ),
//                                 if (widget.changeConnectionInfo)
//                                   Expanded(
//                                     child: ButtonElevated(
//                                         text: 'back'.tr,
//                                         borderRadius: 20,
//                                         backgroundColor: AppColor.brawn,
//                                         onPressed: () async {
//                                           Get.back();
//                                         }),
//                                   ),
//                               ],
//                             );
//                           }
//                         }),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _onPressed() {
//     if (_formKey.currentState!.validate()) {
//       remoteDatabaseSettingController
//           .checkDatabase(SubscriptionInfo(
//               url: urlController.text, db: dbNameController.text))
//           .then((value) async {
//         if (value.status) {
//           appSnackBar(
//             messageType: MessageTypes.success,
//             message: 'success_key_login'.tr,
//           );
//           await SharedPr.removeUserObj();
//           // Get.to(() => const EmployeesListScreen());
//           Get.to(() => const LoginScreen2());
//         } else {
//           appSnackBar(
//             message: value.message!,
//           );
//         }
//       });
//     } else {
//       appSnackBar(
//         message: errorMessage!,
//       );
//     }
//   }
// }

// class test extends StatefulWidget {
//   final bool changeConnectionInfo;
//   final SubscriptionInfo? subscriptionInfo;

//   const test(
//       {super.key, this.changeConnectionInfo = false, this.subscriptionInfo});
//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   DatabaseSettingController remoteDatabaseSettingController =
//       Get.put(DatabaseSettingController.getInstance());
//   TextEditingController dbNameController = TextEditingController();
//   TextEditingController urlController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   String? errorMessage;
//   final keyFocusNode = FocusNode();
//   final _buttonFocusNode = FocusNode();
//   bool flag = false;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.changeConnectionInfo) {
//       dbNameController.text = widget.subscriptionInfo!.db!;
//       urlController.text = widget.subscriptionInfo!.url!;
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       keyFocusNode.requestFocus();
//     });
//   }

//   @override
//   void dispose() {
//     _buttonFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: Get.height,
//           child: Column(
//             children: [
//               Expanded(
//                   flex: 1,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: CustomBackHeader(
//                           height: MediaQuery.of(context).size.height * 0.18,
//                           child: CustomIcon(
//                             assetPath: 'assets/images/image.png',
//                             size: Get.width * 0.3,
//                             color: AppColor.white,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: Container(
//                                     color: Color(0xFFecebf0),
//                                     padding: EdgeInsets.all(5),
//                                     margin: EdgeInsets.all(5),
//                                     child: Icon(
//                                       Icons.info_outline,
//                                       size: Get.width * 0.07,
//                                     ))),
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: Container(
//                                     color: Color(0xFFecebf0),
//                                     padding: EdgeInsets.all(5),
//                                     margin: EdgeInsets.all(5),
//                                     child: Icon(
//                                       Icons.language,
//                                       size: Get.width * 0.07,
//                                     )))
//                           ],
//                         ),
//                       )
//                     ],
//                   )),
//               Expanded(
//                   flex: 3,
//                   child: backgroundlogin(
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(height: Get.height * 0.07),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         'remote_connection_information'.tr,
//                                         style: TextStyle(
//                                             fontSize: Get.width * 0.05,
//                                             fontWeight: FontWeight.bold,
//                                             color: AppColor.white),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: Get.height * 0.02),
//                                 Text(
//                                   'dbName'.tr,
//                                   style: TextStyle(
//                                       fontSize: Get.width * 0.03,
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColor.white),
//                                 ),
//                                 SizedBox(height: Get.height * 0.01),
//                                 ContainerTextField(
//                                   controller: dbNameController,
//                                   borderRadius: 0,
//                                   backgroundColor: Color(0xff1d2e4a),
//                                   prefixIcon: CustomIcon(
//                                     size: Get.width * 0.05,
//                                     padding: 10,
//                                     color: AppColor.white,
//                                     assetPath:
//                                         'assets/images/database-storage.png',
//                                   ),
//                                   hintText: 'dbName'.tr,
//                                   labelText: 'dbName'.tr,
//                                   width: Get.width,
//                                   height:
//                                       MediaQuery.sizeOf(context).height * 0.05,
//                                   hintcolor: AppColor.white.withOpacity(0.5),
//                                   iconcolor: AppColor.white,
//                                   color: AppColor.white,
//                                   fontSize: Get.width * 0.03,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       errorMessage = 'required_message'
//                                           .trParams(
//                                               {'field_name': 'dbName'.tr});

//                                       return "";
//                                     }

//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(
//                                     height: MediaQuery.sizeOf(context).height *
//                                         0.02),
//                                 Text(
//                                   'url'.tr,
//                                   style: TextStyle(
//                                       fontSize: Get.width * 0.03,
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColor.white),
//                                 ),
//                                 SizedBox(height: Get.height * 0.01),
//                                 ContainerTextField(
//                                   backgroundColor: Color(0xff1d2e4a),
//                                   borderRadius: 0,
//                                   controller: urlController,
//                                   prefixIcon: Icon(
//                                     Icons.http_outlined,
//                                     color: AppColor.white,
//                                   ),
//                                   hintText: 'url'.tr,
//                                   labelText: 'url'.tr,
//                                   width: Get.width,
//                                   height:
//                                       MediaQuery.sizeOf(context).height * 0.05,
//                                   hintcolor: AppColor.white.withOpacity(0.5),
//                                   iconcolor: AppColor.white,
//                                   color: AppColor.white,
//                                   fontSize: Get.width * 0.03,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       errorMessage = 'required_message_f'
//                                           .trParams({'field_name': 'url'.tr});
//                                       return "";
//                                     }
//                                     // if (value.isNotEmpty) {
//                                     //   var message = ValidatorHelper.passWordValidation(value: value);
//                                     //   if (message == "") {
//                                     //     return null;
//                                     //   }
//                                     //   errorMessage = message;
//                                     //   return "";
//                                     // }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(
//                                     height: MediaQuery.sizeOf(context).height *
//                                         0.04),
//                                 Obx(() {
//                                   if (remoteDatabaseSettingController
//                                       .isLoading.value) {
//                                     return Center(
//                                       child: CircularProgressIndicator(
//                                         color: AppColor.white,
//                                         backgroundColor: AppColor.black,
//                                       ),
//                                     );
//                                   } else {
//                                     return Row(
//                                       children: [
//                                         if (!widget.changeConnectionInfo)
//                                           Expanded(child: Container()),
//                                         Expanded(
//                                           flex: 2,
//                                           child: ButtonElevated(
//                                               borderRadius: 20,
//                                               text: 'connect'.tr,
//                                               backgroundColor:
//                                                   Color(0xff3157e8),
//                                               onPressed: _onPressed),
//                                         ),
//                                         if (!widget.changeConnectionInfo)
//                                           Expanded(child: Container()),
//                                         if (widget.changeConnectionInfo)
//                                           const SizedBox(
//                                             width: 20,
//                                           ),
//                                         if (widget.changeConnectionInfo)
//                                           Expanded(
//                                             child: ButtonElevated(
//                                                 text: 'back'.tr,
//                                                 borderRadius: 20,
//                                                 backgroundColor:
//                                                     Color(0xff3157e8),
//                                                 onPressed: () async {
//                                                   Get.back();
//                                                 }),
//                                           ),
//                                       ],
//                                     );
//                                   }
//                                 }),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     ));
//   }

//   _onPressed() {
//     if (_formKey.currentState!.validate()) {
//       remoteDatabaseSettingController
//           .checkDatabase(SubscriptionInfo(
//               url: urlController.text, db: dbNameController.text))
//           .then((value) async {
//         if (value.status) {
//           appSnackBar(
//             messageType: MessageTypes.success,
//             message: 'success_key_login'.tr,
//           );
//           await SharedPr.removeUserObj();
//           // Get.to(() => const EmployeesListScreen());
//           Get.to(() => const LoginScreen());
//         } else {
//           appSnackBar(
//             message: value.message!,
//           );
//         }
//       });
//     } else {
//       appSnackBar(
//         message: errorMessage!,
//       );
//     }
//   }
// }

// class backgroundlogin extends StatelessWidget {
//   backgroundlogin({super.key, required this.child});
//   Widget? child;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         CustomBack(
//           height: MediaQuery.of(context).size.height,
//           color: Color(0xFFf4f4f4),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             CustomBack(
//               height: MediaQuery.of(context).size.height * 0.62,
//               color: Color(0xFFecebf0),
//             ),
//           ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             CustomBack(
//               height: MediaQuery.of(context).size.height * 0.52,
//               color: Color(0xFF0f1f40),
//               child: child,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class CustomBack extends StatelessWidget {
  CustomBack({super.key, this.child, this.color, this.height});
  Widget? child;
  double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(
              Get.width,
              height ??
                  Get.height *
                      0.12), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSback2(color: color),
        ),
        child ?? Container()
      ],
    );
  }
}

// class RPSback extends CustomPainter {
//   RPSback({required this.color});

//   final Color? color;
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Layer 1

//     Paint paint_fill_0 = Paint()
//       ..color = color ?? const Color.fromARGB(255, 255, 0, 0)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_0 = Path();
//     path_0.moveTo(size.width * -0.0021833, size.height * 0.1011700);
//     path_0.cubicTo(
//         size.width * 0.1057500,
//         size.height * 0.0247300,
//         size.width * 0.3575667,
//         size.height * 0.0015300,
//         size.width * 0.5000000,
//         size.height * -0.0020000);
//     path_0.cubicTo(
//         size.width * 0.6461833,
//         size.height * 0.0006623,
//         size.width * 0.8767500,
//         size.height * 0.0216600,
//         size.width * 1.0055500,
//         size.height * 0.1016800);
//     path_0.quadraticBezierTo(size.width * 1.0051333, size.height * 0.3023500,
//         size.width * 1.0016667, size.height * 1.0068552);
//     path_0.lineTo(size.width * -0.0016667, size.height * 1.0048535);
//     path_0.quadraticBezierTo(size.width * -0.0034333, size.height * 0.7016800,
//         size.width * -0.0021833, size.height * 0.1011700);
//     path_0.close();

//     canvas.drawPath(path_0, paint_fill_0);

//     // Layer 1

//     Paint paint_stroke_0 = Paint()
//       ..color = color ?? const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_0, paint_stroke_0);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class RPSHeaderbackground extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Layer 1

//     Paint paint_fill_0 = Paint()
//       ..color = Color(0xff3157e8)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_0 = Path();
//     path_0.moveTo(size.width * -0.0052668, size.height * 1.0052888);
//     path_0.cubicTo(
//         size.width * 0.9770031,
//         size.height * 1.0246030,
//         size.width * 1.0014808,
//         size.height * 0.5602680,
//         size.width * 0.9983725,
//         size.height * 0.0019566);
//     path_0.quadraticBezierTo(size.width * 0.7474627, size.height * 0.0036206,
//         size.width * -0.0090966, size.height * -0.0046399);
//     path_0.quadraticBezierTo(size.width * -0.0052668, size.height * 0.2643733,
//         size.width * -0.0052668, size.height * 1.0052888);
//     path_0.close();

//     canvas.drawPath(path_0, paint_fill_0);

//     // Layer 1

//     Paint paint_stroke_0 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_0, paint_stroke_0);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class CustomBackHeader extends StatelessWidget {
//   CustomBackHeader({super.key, this.child, this.color, this.height});
//   Widget? child;
//   double? height;
//   final Color? color;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         CustomPaint(
//           size: Size(
//               Get.width,
//               height ??
//                   Get.height *
//                       0.12), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//           painter: RPSHeaderbackground(),
//         ),
//         child ?? Container()
//       ],
//     );
//   }
// }
class RemoteDatabaseScreen2 extends StatefulWidget {
  final bool changeConnectionInfo;
  // final SubscriptionInfo? subscriptionInfo;

  const RemoteDatabaseScreen2({
    super.key,
    this.changeConnectionInfo = false,
  });

  @override
  State<RemoteDatabaseScreen2> createState() => _RemoteDatabaseScreen2State();
}

class _RemoteDatabaseScreen2State extends State<RemoteDatabaseScreen2> {
  DatabaseSettingController remoteDatabaseSettingController =
      Get.put(DatabaseSettingController.getInstance());
  // TokenController tokenClassController = Get.put(TokenController.getInstance());
  // TextEditingController dbNameController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  final keyFocusNode = FocusNode();
  final _buttonFocusNode = FocusNode();
  bool flag = false;

  @override
  void initState() {
    super.initState();
    // if (widget.changeConnectionInfo) {
    //   // dbNameController.text = widget.subscriptionInfo!.db!;
    //   keyController.text = widget.subscriptionInfo!.url!;
    // }

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
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.white,
          child: Column(
            children: [
              CustomBack(
                height: MediaQuery.of(context).size.height * 0.2,
                color: const Color(0XFF3967d7),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: HeaderIcons(
                            height: Get.width * 0.07,
                            icon: Icons.language,
                            darkBackground: true,
                            onTap: () async {
                              await SharedPr.setLanguage(
                                  lang: SharedPr.lang == 'en' ? 'ar' : 'en');
                            }),
                      ),
                      Expanded(flex: 3, child: Container()),
                      Expanded(flex: 1, child: Container())
                    ],
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: Get.width * 0.6,
                      // color: const Color(0XFF3967d7),
                      padding: const EdgeInsets.only(top: 30),
                      child: CustomIcon(
                        assetPath: 'assets/images/image.png',
                        size: Get.width * 0.6,
                        padding: 10,
                        color: const Color(0XFF3967d7),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.1),
                    Text(
                      'remote_connection_information'.tr,
                      style: TextStyle(
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0XFF3967d7)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: Get.height * 0.05),
                          // Text(
                          //   'dbName'.tr,
                          //   style: TextStyle(
                          //       fontSize: Get.width * 0.03,
                          //       fontWeight: FontWeight.bold,
                          //       color: AppColor.black),
                          // ),
                          // SizedBox(height: Get.height * 0.01),
                          // ContainerTextField(
                          //   controller: dbNameController,
                          //   backgroundColor: AppColor.white,
                          //   prefixIcon: CustomIcon(
                          //       size: Get.width * 0.05,
                          //       padding: 10,
                          //       color: Color(0XFF3967d7),
                          //       assetPath:
                          //           'assets/images/database-storage.png'),
                          //   hintText: 'dbName'.tr,
                          //   labelText: 'dbName'.tr,
                          //   width: Get.width,
                          //   height: MediaQuery.sizeOf(context).height * 0.05,
                          //   hintcolor: AppColor.black.withOpacity(0.5),
                          //   iconcolor: AppColor.black,
                          //   color: AppColor.black,
                          //   fontSize: Get.width * 0.03,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       errorMessage = 'required_message'
                          //           .trParams({'field_name': 'dbName'.tr});

                          //       return "";
                          //     }

                          //     return null;
                          //   },
                          // ),
                          // SizedBox(
                          //     height: MediaQuery.sizeOf(context).height * 0.03),
                          Text(
                            'key_number'.tr,
                            style: TextStyle(
                                fontSize: Get.width * 0.03,
                                fontWeight: FontWeight.bold,
                                color: AppColor.black),
                          ),
                          SizedBox(height: Get.height * 0.01),
                          ContainerTextField(
                            controller: keyController,
                            backgroundColor: AppColor.white,
                            prefixIcon: const Icon(
                              Icons.key,
                              color: Color(0XFF3967d7),
                            ),
                            hintText: 'key_number'.tr,
                            labelText: 'key_number'.tr,
                            width: Get.width,
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            hintcolor: AppColor.black.withOpacity(0.5),
                            iconcolor: AppColor.black,
                            color: AppColor.black,
                            fontSize: Get.width * 0.03,
                            obscureText: flag ? false : true,
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
                                      ? const Icon(
                                          Icons.visibility,
                                          color: Color(0XFF3967d7),
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: AppColor.black,
                                        )),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                errorMessage = 'required_message_f'
                                    .trParams({'field_name': 'key_number'.tr});
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
                              height: MediaQuery.sizeOf(context).height * 0.1),
                          Obx(() {
                            if (remoteDatabaseSettingController
                                .isLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.white,
                                  backgroundColor: AppColor.black,
                                ),
                              );
                            } else {
                              return Row(
                                children: [
                                  Expanded(
                                    child: ButtonElevated(
                                        borderRadius: 20,
                                        text: 'connect'.tr,
                                        backgroundColor:
                                            const Color(0XFF3967d7),
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
                                          backgroundColor:
                                              const Color(0XFF3967d7),
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
            ],
          ),
        ),
      ),
    );
  }

  _onPressed() async {
    if (_formKey.currentState!.validate()) {
      await RemoteDatabaseSettingService.instantiateOdooConnection(
          url: remoteURL,
          db: remotedB,
          username: remoteUsername,
          password: remotePassword);
      remoteDatabaseSettingController
          .checkDatabase(
              loginKey: keyController.text, odooModel: 'subscription.detail')
          .then((value) async {
        if (value.status) {
          await SharedPr.setRemoteDatabaseInfo(
              subscriptionInfo: SubscriptionInfo(
                  url: SharedPrPackage.SharedPr.subscriptionDetailsObj!.url,
                  db: SharedPrPackage.SharedPr.subscriptionDetailsObj!.db));
          appSnackBar(
            messageType: MessageTypes.success,
            message: 'success_key_login'.tr,
          );
          await SharedPr.removeUserObj();
          // Get.to(() => const EmployeesListScreen());
          Get.to(() => const LoginScreen2());
        } else {
          // if (value.data != null) {
          //   CustomDialog.getInstance().dialog(
          //       title: 'error_message',
          //       message: value.message!,
          //       onPressed: () async {
          //         await remoteDatabaseSettingController
          //             .sendTicket(
          //                 subscriptionId: SharedPr
          //                     .subscriptionDetailsObj!.subscriptionId
          //                     .toString(),
          //                 message: value.message!)
          //             .then((value) {
          //           if (value.status) {
          //             Get.back();
          //             appSnackBar(
          //                 message: 'success_send_ticket'.tr,
          //                 messageType: MessageTypes.success);
          //           } else {
          //             appSnackBar(
          //               message: value.message!,
          //             );
          //           }
          //         });
          //       },
          //       dialogType: MessageTypes.error,
          //       primaryButtonText: 'send_ticket');
          // } else {
          appSnackBar(
            message: value.message!,
          );
          // }
        }
      });
    } else {
      appSnackBar(
        message: errorMessage!,
      );
    }
  }
  //   if (_formKey.currentState!.validate()) {
  //     remoteDatabaseSettingController
  //         .checkDatabase(SubscriptionInfo(
  //             url: tokenController.text, db: dbNameController.text))
  //         .then((value) async {
  //       if (value.status) {
  //         appSnackBar(
  //           messageType: MessageTypes.success,
  //           message: 'success_key_login'.tr,
  //         );
  //         await SharedPr.removeUserObj();
  //         // Get.to(() => const EmployeesListScreen());
  //         Get.to(() => const LoginScreen2());
  //       } else {
  //         appSnackBar(
  //           message: value.message!,
  //         );
  //       }
  //     });
  //   } else {
  //     appSnackBar(
  //       message: errorMessage!,
  //     );
  //   }
  // }
}

class RPSback extends CustomPainter {
  RPSback({required this.color});

  final Color? color;

  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = color ?? const Color.fromARGB(255, 255, 0, 0)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0027667, size.height * 0.6699667);
    path_0.quadraticBezierTo(size.width * -0.0019292, size.height * 0.1649917,
        size.width * -0.0016500, size.height * -0.0033333);
    path_0.lineTo(size.width, size.height * 0.0033333);
    path_0.quadraticBezierTo(size.width * 0.9983375, size.height * 0.4983333,
        size.width * 0.9977833, size.height * 0.6633333);
    path_0.cubicTo(
        size.width * 0.7543333,
        size.height * 1.1708667,
        size.width * 0.2483667,
        size.height * 1.1665333,
        size.width * -0.0027667,
        size.height * 0.6699667);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSback2 extends CustomPainter {
  RPSback2({required this.color});

  final Color? color;

  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = color ?? const Color.fromARGB(255, 255, 0, 0)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * -0.0033333);
    path_0.quadraticBezierTo(
        0, size.height * 0.4966667, 0, size.height * 0.6633333);
    path_0.cubicTo(
        size.width * 0.1664583,
        size.height * 1.1162500,
        size.width * 0.8410417,
        size.height * 1.1008333,
        size.width * 0.9991667,
        size.height * 0.6666667);
    path_0.quadraticBezierTo(size.width * 0.9995833, size.height * 0.4991667,
        size.width * 1.0008333, size.height * -0.0033333);
    path_0.lineTo(0, size.height * -0.0033333);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
