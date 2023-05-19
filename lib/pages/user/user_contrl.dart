import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:satsang/pages/user/user_list.dart';

class UserController extends GetxController {
  TextEditingController nameContrl = TextEditingController();
  TextEditingController contactContrl = TextEditingController();
  RxBool isLoading = false.obs;

  Future onNewUserTap() async {
    if (nameContrl.text.isNotEmpty) {
      if (contactContrl.text.isNotEmpty) {
        try {
          isLoading(true);
          // Get a instance to the Firestore collection
          final docUser = FirebaseFirestore.instance.collection("users").doc();
          // create user jsonReq
          final user = UserList(
              id: docUser.id,
              name: nameContrl.text.toString(),
              contactNo: contactContrl.text.toString());
          final jsonReq = user.toJson();
          // create doc and write data in firebase firestore
          await docUser.set(jsonReq).then((value) {
            nameContrl.text = "";
            contactContrl.text = "";
            Fluttertoast.showToast(msg: "New User Added");
            isLoading(false);
            Get.back();
          });
        } catch (e) {
          debugPrint("firebaseError ->> $e");
        }
      } else {
        Fluttertoast.showToast(msg: "Contact No field is Required");
      }
    } else {
      Fluttertoast.showToast(msg: "Name field is Required");
    }
  }

  Future onUpdateUserTap() async {
    if (nameContrl.text.isNotEmpty) {
      if (contactContrl.text.isNotEmpty) {
        try {
          isLoading(true);
          // Get a instance to the Firestore collection
          final docUser = FirebaseFirestore.instance.collection("users");
          // Query for the specific document using its Contact No
          QuerySnapshot querySnapshot = await docUser
              .where(FieldPath.fromString("contactNo"),
                  isEqualTo: contactContrl.text.toString())
              .get();
          // Check if the document exists
          if (querySnapshot.size > 0) {
            // Get the document reference
            DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
            DocumentReference documentRef = documentSnapshot.reference;
            // Update the data using the document reference
            await documentRef.update({
              'name': nameContrl.text.toString(),
            });
            isLoading(false);
            Get.back();
            Fluttertoast.showToast(msg: "Data Updated");
          } else {
            Fluttertoast.showToast(msg: "Data not exist");
          }
        } catch (e) {
          debugPrint("firebaseError ->> $e");
        }
      } else {
        Fluttertoast.showToast(msg: "Contact No field is Required");
      }
    } else {
      Fluttertoast.showToast(msg: "Name field is Required");
    }
  }
}
