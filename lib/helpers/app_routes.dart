import 'package:get/get.dart';
import 'package:satsang/pages/home/home_view.dart';
import 'package:satsang/pages/kirtan/kirtan_view.dart';

class AppRoutes {
  static const String home = "/home";
  static const String kirtan = "/kirtan";

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
    ];
  }
}
