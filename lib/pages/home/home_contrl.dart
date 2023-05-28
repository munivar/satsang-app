import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_images.dart';
import 'package:satsang/helpers/app_routes.dart';
import 'package:satsang/pages/user/user_list.dart';

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

  // - Path List
  List<String> pathList = [
    "વંદુ સહજાનંદ પાઠ",
    "હનુમાનજી મંત્ર",
    "૧૪૨ પરચા પ્રકરણ"
  ];

  // - ondrawerTap
  void ondrawerTap(int index) {
    Get.back();
    if (drawerNameList[index] == "કીર્તન") {
      Get.toNamed(AppRoutes.kirtan);
    }
  }

  // - read user data from firestore
  Stream<List<UserList>> readUsers() =>
      FirebaseFirestore.instance.collection("users").snapshots().map((event) =>
          event.docs.map((doc) => UserList.fromJson(doc.data())).toList());
}
