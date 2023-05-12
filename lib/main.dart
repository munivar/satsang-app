import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_color.dart';
import 'package:satsang/helpers/app_const.dart';
import 'package:satsang/helpers/app_routes.dart';
import 'package:satsang/pages/base_contrl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // -- setup statusbar and navigationbar color
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.backgroundClr,
      statusBarColor: AppColor.primaryClr));
  // -- setup device orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // -- run app from here
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  StartApp({super.key});
  final baseContrl = Get.put(BaseController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.getPages(),
      title: "Satsang",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColor.primaryClr,
        fontFamily: Const.fontFamily,
      ),
    );
  }
}
