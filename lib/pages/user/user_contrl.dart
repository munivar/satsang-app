import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_const.dart';
import 'package:satsang/pages/user/user_list.dart';

class UserController extends GetxController {
  TextEditingController nameContrl = TextEditingController();
  TextEditingController contactContrl = TextEditingController();
  RxBool isLoading = false.obs;
  RxInt totalUser = 0.obs;

  // - adding new user to firestore
  Future onNewUserTap() async {
    if (nameContrl.text.isNotEmpty) {
      if (contactContrl.text.isNotEmpty) {
        try {
          isLoading(true);
          // Get a instance to the Firestore collection
          final collectionRef =
              FirebaseFirestore.instance.collection(Const.fireUsers);
          // Query for the specific document using its Contact No
          QuerySnapshot querySnapshot = await collectionRef
              .where(FieldPath.fromString("contactNo"),
                  isEqualTo: contactContrl.text.toString())
              .get();
          // Check if the document exists
          if (querySnapshot.size > 0) {
            Fluttertoast.showToast(msg: "Devotee is already in list");
            isLoading(false);
          } else {
            // Get a instance to the Firestore collection
            final collectionRef =
                FirebaseFirestore.instance.collection(Const.fireUsers).doc();
            // create user jsonReq
            final user = UserList(
                id: collectionRef.id,
                name: nameContrl.text.toString(),
                contactNo: contactContrl.text.toString(),
                count: "");
            final jsonReq = user.toJson();
            // create doc and write data in firebase firestore
            await collectionRef.set(jsonReq).then((value) {
              nameContrl.text = "";
              contactContrl.text = "";
              Fluttertoast.showToast(msg: "New User Added");
              isLoading(false);
              Get.back();
            });
          }
        } catch (e) {
          debugPrint("firebaseError ->> $e");
          isLoading(false);
        }
      } else {
        Fluttertoast.showToast(msg: "Contact No field is Required");
      }
    } else {
      Fluttertoast.showToast(msg: "Name field is Required");
    }
  }

  // - updating user to firestore
  Future onUpdateUserTap() async {
    if (nameContrl.text.isNotEmpty) {
      if (contactContrl.text.isNotEmpty) {
        try {
          isLoading(true);
          // Get a instance to the Firestore collection
          final collectionRef =
              FirebaseFirestore.instance.collection(Const.fireUsers);
          // Query for the specific document using its Contact No
          QuerySnapshot querySnapshot = await collectionRef
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
            nameContrl.text = "";
            contactContrl.text = "";
            Get.back();
            Fluttertoast.showToast(msg: "Data Updated");
          } else {
            Fluttertoast.showToast(msg: "Data not exist");
            nameContrl.text = "";
            contactContrl.text = "";
            isLoading(false);
          }
        } catch (e) {
          debugPrint("firebaseError ->> $e");
          isLoading(false);
        }
      } else {
        Fluttertoast.showToast(msg: "Contact No field is Required");
      }
    } else {
      Fluttertoast.showToast(msg: "Name field is Required");
    }
  }

  // - deleting user to firestore
  Future onDeleteUserTap() async {
    if (contactContrl.text.isNotEmpty) {
      try {
        isLoading(true);
        // Get a instance to the Firestore collection
        final collectionRef =
            FirebaseFirestore.instance.collection(Const.fireUsers);
        // Query for the specific document using its Contact No
        QuerySnapshot querySnapshot = await collectionRef
            .where(FieldPath.fromString("contactNo"),
                isEqualTo: contactContrl.text.toString())
            .get();
        // Check if the document exists
        if (querySnapshot.size > 0) {
          // Get the document reference
          DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
          DocumentReference documentRef = documentSnapshot.reference;
          // Update the data using the document reference
          await documentRef.delete();
          isLoading(false);
          nameContrl.text = "";
          contactContrl.text = "";
          Get.back();
          Fluttertoast.showToast(msg: "Data Deleted");
        } else {
          Fluttertoast.showToast(msg: "Data not exist");
          nameContrl.text = "";
          contactContrl.text = "";
          isLoading(false);
        }
      } catch (e) {
        debugPrint("firebaseError ->> $e");
        isLoading(false);
      }
    } else {
      Fluttertoast.showToast(msg: "Contact No field is Required");
    }
  }

  // - read user data from firestore
  Stream<List<UserList>> readUsers() => FirebaseFirestore.instance
      .collection(Const.fireUsers)
      .orderBy('name')
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => UserList.fromJson(doc.data())).toList());
}
