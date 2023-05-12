import 'package:get/get.dart';
import 'package:satsang/pages/home/home_view.dart';

class AppRoutes {
  static const String home = "/home";

  static getPages() {
    return [
      GetPage(
        name: home,
        page: () => HomeView(),
        transition: Transition.fadeIn,
      ),
      // GetPage(
      //   name: login,
      //   page: () => LoginView(),
      //   transition: Transition.rightToLeft,
      //   transitionDuration: const Duration(milliseconds: 250),
      // ),
    ];
  }
}
