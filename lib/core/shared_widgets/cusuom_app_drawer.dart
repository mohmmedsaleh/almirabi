import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../features/authentication/presentation/views/login_screen.dart';
import '../../features/authentication/utils/odoo_connection_helper.dart';
import '../../features/basic_data_management/request/presentation/view/reports_list_screen.dart';
import '../../features/basic_data_management/request/presentation/view/request_list_screen.dart';
import '../config/app_colors.dart';
import '../config/app_shared_pr.dart';
import 'app_snack_bar.dart';
import 'custom_app_bar.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              // color: Colors.green, // Change this to your desired color
              // You can also use a gradient if desired
              gradient: LinearGradient(
                end: Alignment.topLeft,
                colors: [
                  AppColor.brawn,
                  const Color.fromRGBO(173, 89, 31, 200),
                ],
              ),
            ),
            accountName: Text(
              '${SharedPr.userObj!.name ?? ''}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.035),
            ),
            accountEmail: Text(
              '',
            ),
            currentAccountPicture: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(1000.0)),
              child: SizedBox(
                width: Get.height * 0.04,
                height: Get.height * 0.04,
                child: CircleAvatar(
                  backgroundColor: AppColor.white,
                  child: SharedPr.userObj!.image_1920 != ''
                      ? isSvg(SharedPr.userObj!.image_1920!)
                          ? SvgPicture.memory(
                              base64.decode(SharedPr.userObj!.image_1920!),
                              clipBehavior: Clip.antiAlias,
                              fit: BoxFit.fill,
                            )
                          : Image.memory(
                              base64Decode(SharedPr.userObj!.image_1920!),
                              // clipBehavior: Clip.antiAlias,
                              fit: BoxFit.fill,
                            )
                      : Icon(
                          color: AppColor.black,
                          Icons.account_circle,
                          size: Get.height * 0.04,
                        ),
                ),
              ),
            ),
          ),

          //   accountName: Container(
          //     child: Text('${SharedPr.userObj!.name ?? ''}'),
          //   ),
          //   accountEmail: null,
          // ),
          // ),
          currentRoute == '/ReportScreen'
              ? Container()
              : ListTile(
                  leading: Icon(
                    Icons.insert_drive_file_outlined,
                    color: AppColor.brawn,
                    size: MediaQuery.of(context).size.width * 0.1,
                  ),
                  title: Text(
                    "Reports".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    // Handle item tap
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    print(connectivityResult);
                    if (connectivityResult.contains(ConnectivityResult.none)) {
                      // No internet connection, switch back to "Requests" tab
                      Get.back();
                      appSnackBar(message: "no_connection".tr);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //       content: Text(
                      //           )),
                      // );
                    } else {
                      Get.to(() => const ReportScreen());
                    }
                    // Close the drawer
                  },
                ),
          currentRoute == '/ReportScreen' ? Container() : Divider(),
          currentRoute == '/RequestListScreen'
              ? Container()
              : ListTile(
                  leading: Icon(
                    Icons.insert_drive_file_outlined,
                    color: AppColor.brawn,
                    size: MediaQuery.of(context).size.width * 0.1,
                  ),
                  title: Text(
                    "requests".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle item tap
                    Get.to(() => const RequestListScreen()); // Close the drawer
                  },
                ),
          currentRoute == '/RequestListScreen' ? Container() : Divider(),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: AppColor.brawn,
              size: MediaQuery.of(context).size.width * 0.1,
            ),
            title: Text(
              "logout".tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              await SharedPr.removeUserObj().then((value) {
                if (value) {
                  OdooProjectOwnerConnectionHelper.odooSession = null;
                  Get.deleteAll();
                  Get.offAll(() => const LoginScreen());
                }
              }); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
