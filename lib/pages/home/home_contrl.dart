import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_images.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  // - drawer name list
  List<String> drawerNameList = [
    "કીર્તન",
  ];

  // - drawer icon list
  List<String> drawerIconList = [
    AppImages.musicIcon,
  ];
}
