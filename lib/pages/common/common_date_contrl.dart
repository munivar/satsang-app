import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_const.dart';
import 'package:satsang/helpers/app_helper.dart';
import 'package:satsang/pages/common/common_date_list.dart';

class CommonDateController extends GetxController {
  RxBool isLoading = false.obs;
  RxString headName = "".obs;

  @override
  void onInit() {
    headName.value = Get.arguments["headName"];
    super.onInit();
  }

  // - read user data from firestore
  Stream<List<CommonDateList>> readDateList() => FirebaseFirestore.instance
      .collection(headName.value == Const.vanduPath
          ? Const.fireVandu
          : headName.value == Const.hanumanjiMantra
              ? Const.fireHanumanji
              : Const.fireParcha)
      .orderBy('date')
      .snapshots()
      .map((event) => event.docs
          .map((doc) => CommonDateList.fromJson(doc.data()))
          .toList());

  Future<DateTime?> pickDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2200),
      );

  onAddButtonTap(BuildContext context) async {
    try {
      DateTime? date = await pickDate(context);
      if (date == null) return;
      isLoading(true);
      final finalDate = AppHelper.formateDate(date);
      // Get a instance to the Firestore collection
      final documentRef = FirebaseFirestore.instance
          .collection(headName.value == Const.vanduPath
              ? Const.fireVandu
              : headName.value == Const.hanumanjiMantra
                  ? Const.fireHanumanji
                  : Const.fireParcha)
          .doc();
      // create user jsonReq
      final user = CommonDateList(id: documentRef.id, date: finalDate);
      final jsonReq = user.toJson();
      // create doc and write data in firebase firestore
      await documentRef.set(jsonReq).then((value) {
        Fluttertoast.showToast(msg: "New Collection Added");
        isLoading(false);
      });
      // final subDocumentRef = FirebaseFirestore.instance
      //     .collection("vandu")
      //     .doc(documentRef.id)
      //     .collection(date)
      //     .doc();
      // await subDocumentRef.set(jsonReq).then((value) {
      //   nameContrl.text = "";
      //   contactContrl.text = "";
      //   Fluttertoast.showToast(msg: "New User Added");
      //   isLoading(false);
      //   Get.back();
      // });
    } catch (e) {
      debugPrint("error ->> $e");
    }
  }
}
