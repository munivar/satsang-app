import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_color.dart';
import 'package:satsang/helpers/app_helper.dart';
import 'package:satsang/helpers/app_images.dart';
import 'package:satsang/helpers/app_routes.dart';
import 'package:satsang/pages/base_contrl.dart';
import 'package:satsang/pages/home/drawer_view.dart';
import 'package:satsang/pages/home/home_contrl.dart';
import 'package:satsang/widgets/app_text.dart';
import 'package:satsang/widgets/button_box.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final baseContrl = Get.find<BaseController>();
  final contrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    baseContrl.initPlatformSetup(context);
    return SafeArea(
      child: Scaffold(
        key: contrl.drawerKey,
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
                  contrl.drawerKey.currentState!.openDrawer();
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHelper.sizedBox(context, 1, null),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              AppHelper.sizedBox(context, 0.5, null),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: AppButtonBox(
                  isClickable: true,
                  onTap: () {
                    Get.toNamed(AppRoutes.user);
                  },
                  child: Center(
                    child: AppText(
                      text: "ભક્તોની યાદી",
                      fontColor: Colors.white,
                      fontSize: AppHelper.font(context, 16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              AppHelper.sizedBox(context, 0.5, null),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              AppHelper.sizedBox(context, 0.5, null),
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemCount: contrl.pathList.length,
                  itemBuilder: (context, index) {
                    var items = contrl.pathList;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: AppButtonBox(
                        isClickable: true,
                        onTap: () {
                          Get.toNamed(AppRoutes.commonDate,
                              arguments: {"headName": items[index]});
                        },
                        child: Center(
                          child: AppText(
                            text: items[index],
                            fontColor: Colors.white,
                            fontSize: AppHelper.font(context, 16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
              AppHelper.sizedBox(context, 0.5, null),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              AppHelper.sizedBox(context, 0.5, null),
            ],
          ),
        ));
  }
}
