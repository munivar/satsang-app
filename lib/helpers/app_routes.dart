import 'package:get/get.dart';
import 'package:satsang/pages/common/common_date_view.dart';
import 'package:satsang/pages/common/common_user_view.dart';
import 'package:satsang/pages/home/home_view.dart';
import 'package:satsang/pages/kirtan/kirtan_view.dart';
import 'package:satsang/pages/user/user_view.dart';

class AppRoutes {
  static const String home = "/home";
  static const String kirtan = "/kirtan";
  static const String user = "/user";
  static const String commonDate = "/commonDate";
  static const String commonUser = "/commonUser";

  static getPages() {
    return [
      GetPage(
        name: home,
        page: () => HomeView(),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: kirtan,
        page: () => KirtanView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: user,
        page: () => UserView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: commonDate,
        page: () => CommonDateView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: commonUser,
        page: () => CommonUserView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 250),
      ),
    ];
  }
}
