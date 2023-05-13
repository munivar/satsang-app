import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_helper.dart';
import 'package:satsang/helpers/app_routes.dart';
import 'package:satsang/pages/home/home_contrl.dart';
import 'package:satsang/widgets/app_text.dart';

class DrawerView extends StatelessWidget {
  DrawerView({super.key});
  final homeContrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppHelper.sizedBox(context, 5, null),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: homeContrl.drawerNameList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.back();
                    if (homeContrl.drawerNameList[index] == "કીર્તન") {
                      Get.toNamed(AppRoutes.kirtan);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppHelper.width(context, 7)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          homeContrl.drawerIconList[index],
                          height: 22,
                          width: 22,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppHelper.width(context, 4),
                              vertical: AppHelper.height(context, 1)),
                          child: AppText(
                            text: homeContrl.drawerNameList[index],
                            fontSize: AppHelper.font(context, 17),
                            fontColor: const Color(0xff53596A),
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 5,
                color: Colors.transparent,
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 5, bottom: 15),
          //     child: AppText(
          //       text: "App Version 1.0.0",
          //       fontSize: AppHelper.font(context, 13),
          //       fontColor: const Color(0xff53596A),
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
