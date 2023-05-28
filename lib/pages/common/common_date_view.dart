import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_color.dart';
import 'package:satsang/helpers/app_helper.dart';
import 'package:satsang/helpers/app_images.dart';
import 'package:satsang/helpers/app_routes.dart';
import 'package:satsang/pages/base_contrl.dart';
import 'package:satsang/pages/common/common_date_contrl.dart';
import 'package:satsang/widgets/app_text.dart';
import 'package:satsang/widgets/button_box.dart';
import 'package:satsang/widgets/loader_widget.dart';

class CommonDateView extends StatelessWidget {
  CommonDateView({super.key});
  final baseContrl = Get.find<BaseController>();
  final contrl = Get.put(CommonDateController());

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
            Obx(() {
              return AppText(
                text: contrl.headName.value,
                fontSize: AppHelper.font(context, 20),
                fontColor: Colors.white,
                fontWeight: FontWeight.w600,
              );
            }),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  contrl.onAddButtonTap(context);
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
              Obx(() {
                return contrl.isLoading.isTrue
                    ? SizedBox(
                        height: 40,
                        child: AppLoaderWidget(
                          color: AppColor.primaryClr,
                        ),
                      )
                    : StreamBuilder(
                        stream: contrl.readDateList(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final items = snapshot.data!;
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const ScrollPhysics(),
                                itemCount: items.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: AppButtonBox(
                                      isClickable: true,
                                      onTap: () {
                                        Get.toNamed(AppRoutes.commonUser);
                                      },
                                      child: Center(
                                        child: AppText(
                                          text: items[index].date,
                                          fontColor: Colors.white,
                                          fontSize: AppHelper.font(context, 16),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                });
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
                        });
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
