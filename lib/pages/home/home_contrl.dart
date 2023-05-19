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
    // "કીર્તન",
    "User Management"
  ];

  // - drawer icon list
  List<String> drawerIconList = [
    // AppImages.musicIcon,
    AppImages.userIcon,
  ];

  void ondrawerTap(int index) {
    Get.back();
    if (drawerNameList[index] == "કીર્તન") {
      Get.toNamed(AppRoutes.kirtan);
    } else if (drawerNameList[index] == "User Management") {
      Get.toNamed(AppRoutes.user);
    }
  }

  Stream<List<UserList>> readUsers() =>
      FirebaseFirestore.instance.collection("users").snapshots().map((event) =>
          event.docs.map((doc) => UserList.fromJson(doc.data())).toList());
}
