import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

import '../../features/authentication/presentation/views/login_screen.dart';
import '../../features/authentication/utils/odoo_connection_helper.dart';

import '../config/app_colors.dart';
import '../config/app_enums.dart';
import '../config/app_lists.dart';
import '../config/app_shared_pr.dart';
import '../config/app_styles.dart';
import 'app_header_icons.dart';
// import '../config/app_colors.dart';
// import '../config/app_shared_pr.dart';

PreferredSizeWidget customAppBar(
    {bool headerBackground = false, bool userOpstionShow = false}) {
  Widget buildWelcomeMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${"welcomeBack".tr} ${SharedPr.userObj!.name}',
          style: AppStyle.textStyle(
            fontSize: Get.width * 0.01,
            fontWeight: FontWeight.bold,
            color: AppColor.white,
          ),
        ),
      ],
    );
  }

  Widget buildUserMenuOption(
      {required dynamic icon, required String label, Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              icon is IconData
                  ? Icon(
                      icon,
                      size: Get.height * 0.02,
                    )
                  : Image.asset(
                      icon,
                      width: Get.height * 0.02,
                      height: Get.height * 0.02,
                    ),
              const SizedBox(width: 10),
              Text(
                label.tr,
                style: TextStyle(fontSize: Get.width * 0.007),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build the user menu
  Widget buildUserMenu() {
    return Builder(builder: (buildContext) {
      return InkWell(
        onTap: () {
          if (userOpstionShow == false) {
            showPopover(
              context: buildContext,
              width: Get.width * 0.15,
              height: Get.height * 0.15,
              backgroundColor: AppColor.white.withOpacity(0.5),
              bodyBuilder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // buildUserMenuOption(
                    //     icon: "assets/image/enable_pin.png",
                    //     label: (SharedPr.userObj?.pinCode == null)
                    //         ? 'enable_pin_login'.tr
                    //         : 'disable_pin_login'.tr,
                    //     onTap: () async {
                    //       Navigator.of(context).pop();
                    //       bool trustedDevice =
                    //           await MacAddressHelper.isTrustedDevice();
                    //       if (trustedDevice) {
                    //         activatePINLogin(
                    //             enable: (SharedPr.userObj!.pinCode == null)
                    //                 ? true
                    //                 : false);
                    //       }
                    //     }),
                    // buildUserMenuOption(
                    //     icon: "assets/image/change_passowrd.png",
                    //     label: 'change_password'.tr,
                    //     onTap: () async {
                    //       Navigator.of(context).pop();
                    //       bool trustedDevice =
                    //           await MacAddressHelper.isTrustedDevice();
                    //       if (trustedDevice) {
                    //         changePasswordDialog();
                    //       }
                    //     }),
                    buildUserMenuOption(
                        icon: Icons.logout_rounded,
                        label: "logout".tr,
                        onTap: () async {
                          await SharedPr.removeUserObj().then((value) {
                            if (value) {
                              OdooProjectOwnerConnectionHelper.odooSession =
                                  null;
                              Get.deleteAll();
                              Get.offAll(() => const LoginScreen());
                            }
                          });
                        }),
                  ],
                );
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              if (Get.currentRoute == "/NotificationScreen") ...[
                BackButton(
                  color: AppColor.white,
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(1000.0)),
                child: SizedBox(
                  width: Get.height * 0.04,
                  height: Get.height * 0.04,
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
                          // color: AppColor.white,
                          Icons.account_circle,
                          size: Get.height * 0.04,
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // final SocketController socketController =  Get.put<SocketController>(SocketController(), permanent:true);

  return PreferredSize(
    preferredSize: Size(
        Get.width, !headerBackground ? Get.height * 0.07 : Get.height * 0.05),
    child: Container(
      // padding: const EdgeInsets.all(15),
      height: !headerBackground ? Get.height * 0.07 : Get.height * 0.05,
      decoration: BoxDecoration(
          color: headerBackground ? AppColor.purple : Colors.transparent,
          borderRadius: BorderRadius.only(
              bottomLeft: SharedPr.lang == "en"
                  ? Radius.zero
                  : const Radius.circular(20),
              bottomRight: SharedPr.lang == "ar"
                  ? Radius.zero
                  : const Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (SharedPr.userObj != null && Get.currentRoute != "/KeyScreen")
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildUserMenu(),
                  buildWelcomeMessage(),
                ],
              ),
            Row(
              children: [
                HeaderIcons(
                    icon: Icons.language,
                    darkBackground: headerBackground,
                    onTap: () async {
                      await SharedPr.setLanguage(
                          lang: SharedPr.lang == 'en' ? 'ar' : 'en');
                    }),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

bool isSvg(String data) {
  // Check if the data starts with the '<svg' tag

  // print("mohmmed ${String.fromCharCodes(base64.decode(data))}");
  return String.fromCharCodes(base64.decode(data)).endsWith('</svg>');
}
