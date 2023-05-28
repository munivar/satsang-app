import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:satsang/pages/user/user_list.dart';

class CommonUserController extends GetxController {
  // - read user data from firestore
  Stream<List<UserList>> readUsers() =>
      FirebaseFirestore.instance.collection("users").snapshots().map((event) =>
          event.docs.map((doc) => UserList.fromJson(doc.data())).toList());
}
