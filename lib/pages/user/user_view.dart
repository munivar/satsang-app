import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_color.dart';
import 'package:satsang/helpers/app_helper.dart';
import 'package:satsang/helpers/app_images.dart';
import 'package:satsang/pages/base_contrl.dart';
import 'package:satsang/pages/user/user_contrl.dart';
import 'package:satsang/widgets/app_text.dart';
import 'package:satsang/widgets/button_box.dart';
import 'package:satsang/widgets/loader_widget.dart';
import 'package:satsang/widgets/text_filed.dart';

class UserView extends StatelessWidget {
  UserView({super.key});
  final baseContrl = Get.find<BaseController>();
  final userContrl = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    baseContrl.initPlatformSetup(context);
    return SafeArea(
      child: Scaffold(
        appBar: appbarLayout(context),
        body: mainLayout(context),
      ),
    );
  }

  appbarLayout(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryClr,
      toolbarHeight: 60,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        height: 60,
        padding:
            EdgeInsets.symmetric(horizontal: AppHelper.width(context, 2.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppImages.backIcon,
                    color: Colors.white,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ),
            AppText(
              text: "User Management",
              fontSize: AppHelper.font(context, 20),
              fontColor: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            AppHelper.sizedBox(context, null, 8),
            // Material(
            //   color: Colors.transparent,
            //   child: InkWell(
            //     onTap: () {
            //       dashboardContrl.openBottomSheet();
            //     },
            //     borderRadius: BorderRadius.circular(50),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8),
            //       child: SvgPicture.asset(
            //         AppImages.languageIcon,
            //         color: AppColor.primaryClr,
            //         height: 23,
            //         width: 23,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  mainLayout(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColor.backgroundClr,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              AppHelper.sizedBox(context, 4, null),
              AppButtonBox(
                isClickable: true,
                onTap: () {
                  addNewUserSheet();
                },
                child: Center(
                  child: AppText(
                    text: "Add New User",
                    fontColor: Colors.white,
                    fontSize: AppHelper.font(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AppHelper.sizedBox(context, 2, null),
              AppButtonBox(
                isClickable: true,
                onTap: () {
                  updateUserSheet();
                },
                child: Center(
                  child: AppText(
                    text: "Update User",
                    fontColor: Colors.white,
                    fontSize: AppHelper.font(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AppHelper.sizedBox(context, 2, null),
              AppButtonBox(
                isClickable: true,
                onTap: () {
                  deleteUserSheet();
                },
                child: Center(
                  child: AppText(
                    text: "Delete User",
                    fontColor: Colors.white,
                    fontSize: AppHelper.font(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AppHelper.sizedBox(context, 2, null),
            ],
          ),
        ));
  }

  // - AddNewUserSheet
  addNewUserSheet() {
    Get.bottomSheet(
      StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          height: AppHelper.height(context, 50),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AppHelper.sizedBox(context, 4, null),
                AppText(
                  text: "Add New User",
                  fontSize: AppHelper.font(context, 20),
                  fontWeight: FontWeight.w600,
                ),
                AppHelper.sizedBox(context, 2, null),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: AppText(
                      text: "User Name",
                      fontSize: AppHelper.font(context, 16),
                    ),
                  ),
                ),
                AppTextField(
                  hintText: "Enter User Name ...",
                  controller: userContrl.nameContrl,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
                AppHelper.sizedBox(context, 0.5, null),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: AppText(
                      text: "Contact No",
                      fontSize: AppHelper.font(context, 16),
                    ),
                  ),
                ),
                AppTextField(
                  hintText: "Enter Contact No ...",
                  controller: userContrl.contactContrl,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                AppHelper.sizedBox(context, 2, null),
                AppButtonBox(
                  isClickable: true,
                  onTap: () {
                    userContrl.onNewUserTap();
                  },
                  child: Center(
                    child: Obx(() {
                      return userContrl.isLoading.isFalse
                          ? AppText(
                              text: "Add New User",
                              fontColor: Colors.white,
                              fontSize: AppHelper.font(context, 16),
                              fontWeight: FontWeight.w600,
                            )
                          : const AppLoaderWidget();
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      backgroundColor: Colors.white,
      elevation: 0,
      persistent: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );
  }

  // - updateUserSheet
  updateUserSheet() {
    Get.bottomSheet(
      StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          height: AppHelper.height(context, 54),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AppHelper.sizedBox(context, 4, null),
                AppText(
                  text: "Update User",
                  fontSize: AppHelper.font(context, 20),
                  fontWeight: FontWeight.w600,
                ),
                AppHelper.sizedBox(context, 2, null),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: AppText(
                      text: "Contact No",
                      fontSize: AppHelper.font(context, 16),
                    ),
                  ),
                ),
                AppTextField(
                  hintText: "Enter Contact No ...",
                  controller: userContrl.contactContrl,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                AppHelper.sizedBox(context, 0.5, null),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: AppText(
                      text: "*You can change User Name using User Mobile No",
                      fontSize: AppHelper.font(context, 12),
                      fontColor: Colors.red,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: AppText(
                      text: "User Name",
                      fontSize: AppHelper.font(context, 16),
                    ),
                  ),
                ),
                AppTextField(
                  hintText: "Enter New User Name ...",
                  controller: userContrl.nameContrl,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
                AppHelper.sizedBox(context, 2, null),
                AppButtonBox(
                  isClickable: true,
                  onTap: () {
                    userContrl.onUpdateUserTap();
                  },
                  child: Center(
                    child: Obx(() {
                      return userContrl.isLoading.isFalse
                          ? AppText(
                              text: "Update User",
                              fontColor: Colors.white,
                              fontSize: AppHelper.font(context, 16),
                              fontWeight: FontWeight.w600,
                            )
                          : const AppLoaderWidget();
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      backgroundColor: Colors.white,
      elevation: 0,
      persistent: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );
  }

  // deleteUserSheet
  deleteUserSheet() {
    Get.bottomSheet(
      StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          height: AppHelper.height(context, 46),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AppHelper.sizedBox(context, 4, null),
                AppText(
                  text: "Delete User",
                  fontSize: AppHelper.font(context, 20),
                  fontWeight: FontWeight.w600,
                ),
                AppHelper.sizedBox(context, 2, null),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: AppText(
                      text: "Contact No",
                      fontSize: AppHelper.font(context, 16),
                    ),
                  ),
                ),
                AppTextField(
                  hintText: "Enter Contact No ...",
                  controller: userContrl.contactContrl,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                AppHelper.sizedBox(context, 2, null),
                AppButtonBox(
                  isClickable: true,
                  onTap: () {
                    userContrl.onDeleteUserTap();
                  },
                  child: Center(
                    child: Obx(() {
                      return userContrl.isLoading.isFalse
                          ? AppText(
                              text: "Delete User",
                              fontColor: Colors.white,
                              fontSize: AppHelper.font(context, 16),
                              fontWeight: FontWeight.w600,
                            )
                          : const AppLoaderWidget();
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      backgroundColor: Colors.white,
      elevation: 0,
      persistent: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );
  }
}
