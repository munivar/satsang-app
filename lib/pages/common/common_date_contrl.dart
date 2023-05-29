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
      final jsonModel =
          CommonDateList(id: documentRef.id, date: finalDate, count: "");
      final jsonReq = jsonModel.toJson();
      // create doc and write data in firebase firestore
      await documentRef.set(jsonReq);
      ///////////////////////////////////////////////////////////////////////////////////
      // Get a reference to the source collection
      CollectionReference sourceCollection =
          FirebaseFirestore.instance.collection(Const.fireUsers);
      // Get a reference to the destination collection
      CollectionReference destinationCollection = FirebaseFirestore.instance
          .collection(headName.value == Const.vanduPath
              ? Const.fireVandu
              : headName.value == Const.hanumanjiMantra
                  ? Const.fireHanumanji
                  : Const.fireParcha)
          .doc(documentRef.id)
          .collection(finalDate);
      // Retrieve the documents from the source collection
      QuerySnapshot querySnapshot = await sourceCollection.get();
      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through each document
        for (var document in querySnapshot.docs) {
          // Get the data from the document
          var data = document.data() as Map<String, dynamic>;
          // Add the data to the destination collection
          destinationCollection.add({
            'id': data["id"],
            'name': data["name"],
            'contactNo': data["contactNo"],
            'count': "",
          }).then((_) {
            debugPrint("Document Copied Sucessfully");
            isLoading(false);
          }).catchError((error) {
            debugPrint('Error copying document: $error');
            isLoading(false);
          });
        }
      } else {
        debugPrint('No documents found in the source collection.');
        isLoading(false);
      }
      Fluttertoast.showToast(msg: "New Collection Added");
      ///////////////////////////////////////////////////////////////////////////////////
    } catch (e) {
      debugPrint("error ->> $e");
    }
  }
}
