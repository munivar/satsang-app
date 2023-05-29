import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_const.dart';
import 'package:satsang/pages/user/user_list.dart';

class CommonUserController extends GetxController {
  RxString headName = "".obs;
  RxString headDate = "".obs;
  RxString headDocId = "".obs;

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
}
