import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_color.dart';
import 'package:satsang/helpers/app_helper.dart';
import 'package:satsang/helpers/app_images.dart';
import 'package:satsang/pages/base_contrl.dart';
import 'package:satsang/pages/home/drawer_view.dart';
import 'package:satsang/pages/home/home_contrl.dart';
import 'package:satsang/widgets/app_text.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final baseContrl = Get.find<BaseController>();
  final homeContrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: homeContrl.drawerKey,
        appBar: appbarLayout(context),
        body: mainLayout(context),
        drawer: DrawerView(),
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
                  homeContrl.drawerKey.currentState!.openDrawer();
                },
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppImages.menuIcon,
                    color: Colors.white,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
            AppText(
              text: "સત્સંગ",
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
              AppHelper.sizedBox(context, 2, null),
            ],
          ),
        ));
  }
}
