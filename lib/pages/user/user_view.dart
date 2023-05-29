import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/anim/fade_animation.dart';
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
  final contrl = Get.put(UserController());

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
              text: "ભક્તોની યાદી",
              fontSize: AppHelper.font(context, 20),
              fontColor: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      contrl.nameContrl.text = "";
                      contrl.contactContrl.text = "";
                      addNewUserSheet();
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        AppImages.addIcon,
                        color: Colors.white,
                        height: 23,
                        width: 23,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      contrl.nameContrl.text = "";
                      contrl.contactContrl.text = "";
                      updateUserSheet();
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        AppImages.editIcon,
                        color: Colors.white,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      contrl.nameContrl.text = "";
                      contrl.contactContrl.text = "";
                      deleteUserSheet();
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        AppImages.deleteIcon,
                        color: Colors.white,
                        height: 23,
                        width: 23,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
              AppHelper.sizedBox(context, 1, null),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Obx(() {
                    return AppText(
                      text: "Total ${contrl.totalUser.value} Devotees",
                      fontSize: AppHelper.font(context, 20),
                      fontWeight: FontWeight.bold,
                    );
                  })),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              AppHelper.sizedBox(context, 0.5, null),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: AppHelper.width(context, 40),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: AppText(
                          text: "Devotee Name",
                          maxLines: 2,
                          fontSize: 18,
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppHelper.width(context, 30),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: AppText(
                          text: "Contact No",
                          fontSize: 18,
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppHelper.sizedBox(context, 1, null),
              StreamBuilder(
                  stream: contrl.readUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // call this fun after windget initialized
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        contrl.totalUser.value = snapshot.data!.length;
                      }); //////
                      final items = snapshot.data!;
                      if (items.isNotEmpty) {
                        return FadeAppAnimation(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: AppHelper.width(context, 40),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
                                          child: AppText(
                                            text: items[index].name,
                                            maxLines: 2,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: AppHelper.width(context, 30),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
                                          child: AppText(
                                            text: items[index].contactNo,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        );
                      } else {
                        return const Center(child: AppText(text: "No Data"));
                      }
                    } else {
                      return Center(
                        child: SizedBox(
                          height: 40,
                          child: AppLoaderWidget(
                            color: AppColor.primaryClr,
                          ),
                        ),
                      );
                    }
                  }),
              AppHelper.sizedBox(context, 0.5, null),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              AppHelper.sizedBox(context, 1, null),
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
                  text: "Add New Devotee",
                  fontSize: AppHelper.font(context, 20),
                  fontWeight: FontWeight.w600,
                ),
                AppHelper.sizedBox(context, 2, null),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: AppText(
                      text: "Devotee Name",
                      fontSize: AppHelper.font(context, 16),
                    ),
                  ),
                ),
                AppTextField(
                  hintText: "Enter Devotee Name ...",
                  controller: contrl.nameContrl,
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
                  controller: contrl.contactContrl,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                AppHelper.sizedBox(context, 2, null),
                AppButtonBox(
                  isClickable: true,
                  onTap: () {
                    contrl.onNewUserTap();
                  },
                  child: Center(
                    child: Obx(() {
                      return contrl.isLoading.isFalse
                          ? AppText(
                              text: "Add New Devotee",
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
                  text: "Edit Devotee Details",
                  fontSize: AppHelper.font(context, 20),
                  fontWeight: FontWeight.w600,
                ),
                AppHelper.sizedBox(context, 2, null),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: AppText(
                      text: "Devotee Contact No",
                      fontSize: AppHelper.font(context, 16),
                    ),
                  ),
                ),
                AppTextField(
                  hintText: "Enter Contact No ...",
                  controller: contrl.contactContrl,
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
                      text: "Devotee Name",
                      fontSize: AppHelper.font(context, 16),
                    ),
                  ),
                ),
                AppTextField(
                  hintText: "Enter New Devotee Name ...",
                  controller: contrl.nameContrl,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
                AppHelper.sizedBox(context, 2, null),
                AppButtonBox(
                  isClickable: true,
                  onTap: () {
                    contrl.onUpdateUserTap();
                  },
                  child: Center(
                    child: Obx(() {
                      return contrl.isLoading.isFalse
                          ? AppText(
                              text: "Update Devotee",
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
                  text: "Delete Devotee",
                  fontSize: AppHelper.font(context, 20),
                  fontWeight: FontWeight.w600,
                ),
                AppHelper.sizedBox(context, 2, null),
                AppHelper.sizedBox(context, 0.5, null),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: AppText(
                      maxLines: 2,
                      text:
                          "*Devotee Data are not recoverable after Deletetion",
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
                      text: "Contact No",
                      fontSize: AppHelper.font(context, 16),
                    ),
                  ),
                ),
                AppTextField(
                  hintText: "Enter Contact No ...",
                  controller: contrl.contactContrl,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                AppHelper.sizedBox(context, 2, null),
                AppButtonBox(
                  isClickable: true,
                  onTap: () {
                    contrl.onDeleteUserTap();
                  },
                  child: Center(
                    child: Obx(() {
                      return contrl.isLoading.isFalse
                          ? AppText(
                              text: "Delete Devotee",
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
