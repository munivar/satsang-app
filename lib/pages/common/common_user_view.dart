import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_color.dart';
import 'package:satsang/helpers/app_helper.dart';
import 'package:satsang/helpers/app_images.dart';
import 'package:satsang/helpers/app_routes.dart';
import 'package:satsang/pages/base_contrl.dart';
import 'package:satsang/pages/common/common_user_contrl.dart';
import 'package:satsang/widgets/app_text.dart';
import 'package:satsang/widgets/button_box.dart';
import 'package:satsang/widgets/loader_widget.dart';
import 'package:satsang/widgets/text_filed.dart';

class CommonUserView extends StatelessWidget {
  CommonUserView({super.key});
  final baseContrl = Get.find<BaseController>();
  final contrl = Get.put(CommonUserController());

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
              text: "વંદુ સહજાનંદ પાઠ",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: AppHelper.width(context, 40),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: AppText(
                          text: "Name",
                          maxLines: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 15),
                    //   child: SizedBox(
                    //     width: AppHelper.width(context, 25),
                    //     child: const Padding(
                    //       padding: EdgeInsets.only(bottom: 4),
                    //       child: AppText(
                    //         text: "Contact No",
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: AppHelper.width(context, 30),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 4),
                        child: AppText(
                          text: "Count",
                          fontSize: 18,
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
                      final items = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          itemCount: items.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: AppHelper.width(context, 40),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: AppText(
                                        text: items[index].name,
                                        maxLines: 2,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 15),
                                  //   child: SizedBox(
                                  //     width: AppHelper.width(context, 25),
                                  //     child: Padding(
                                  //       padding:
                                  //           const EdgeInsets.only(bottom: 4),
                                  //       child: AppText(
                                  //         text: items[index].contactNo,
                                  //         fontSize: 18,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  AppTextField(
                                    height: 45,
                                    maxLines: 1,
                                    width: AppHelper.width(context, 30),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    contentPadding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 18),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return const Center(child: AppLoaderWidget());
                    }
                  }),
              AppHelper.sizedBox(context, 1, null),
            ],
          ),
        ));
  }
}
