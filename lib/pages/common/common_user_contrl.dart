import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_const.dart';
import 'package:satsang/pages/user/user_list.dart';

class CommonUserController extends GetxController {
  RxString headName = "".obs;
  RxString headDate = "".obs;
  RxString headDocId = "".obs;
  final countContrl = <TextEditingController>[].obs;
  Timer apiTimer = Timer(const Duration(milliseconds: 600), () {});

  @override
  void onClose() {
    for (var controller in countContrl) {
      controller.dispose();
    }
    super.onClose();
  }

  @override
  void onInit() {
    headName.value = Get.arguments["headName"];
    headDate.value = Get.arguments["headDate"];
    headDocId.value = Get.arguments["headDocId"];
    super.onInit();
  }

  // - read user data from firestore
  Stream<List<UserList>> readUsers() => FirebaseFirestore.instance
      .collection(headName.value == Const.vanduPath
          ? Const.fireVandu
          : headName.value == Const.hanumanjiMantra
              ? Const.fireHanumanji
              : Const.fireParcha)
      .doc(headDocId.value)
      .collection(headDate.value)
      .orderBy('name')
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => UserList.fromJson(doc.data())).toList());

  void resetTimer(int index, String value, UserList item) {
    apiTimer.cancel();
    apiTimer = Timer(const Duration(milliseconds: 400), () {
      onFieldValueChanged(index, value, item);
    });
  }

  // - onValue Changed
  onFieldValueChanged(int index, String value, UserList item) async {
    if (countContrl[index].text.isNotEmpty) {
      try {
        // Get a instance to the Firestore collection
        final collectionRef = FirebaseFirestore.instance
            .collection(headName.value == Const.vanduPath
                ? Const.fireVandu
                : headName.value == Const.hanumanjiMantra
                    ? Const.fireHanumanji
                    : Const.fireParcha)
            .doc(headDocId.value)
            .collection(headDate.value);
        // Query for the specific document using its Contact No
        QuerySnapshot querySnapshot = await collectionRef
            .where(FieldPath.fromString("contactNo"), isEqualTo: item.contactNo)
            .get();
        // Check if the document exists
        if (querySnapshot.size > 0) {
          // Get the document reference
          DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
          DocumentReference documentRef = documentSnapshot.reference;
          debugPrint("reff ->> ${item.contactNo}");
          debugPrint("reff ->> ${countContrl[index].text}");
          // Update the data using the document reference
          await documentRef.update({
            'count': countContrl[index].text.toString(),
          });

          //////////////////////////////////////////////
          int sum = 0;
          try {
            QuerySnapshot totalSnapshot = await collectionRef.get();
            if (totalSnapshot.docs.isNotEmpty) {
              for (var document in totalSnapshot.docs) {
                // Get the data from the document
                var data = document.data() as Map<String, dynamic>;
                int finalCount = int.parse(data["count"]);
                sum = sum + finalCount;
              }
            }
          } catch (e) {
            debugPrint("totalCount ->> $e");
          }
          debugPrint("totalCount ->> $sum");
          /////////////////////////////////////////////
        } else {
          Fluttertoast.showToast(msg: "Data not exist");
        }
      } catch (e) {
        debugPrint("firebaseError ->> $e");
      }
    }
  }
}
