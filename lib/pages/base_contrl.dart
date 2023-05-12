import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  RxString currentPlatform = "".obs; // -- isAndroid, isiOS, isWeb
  RxBool isLandscape = false.obs;
  RxBool isMobile = false.obs;
  RxBool isTablet = false.obs;
  RxBool isDesktop = false.obs;

  // -- check platform and device
  void initPlatformSetup(BuildContext context) {
    // -- check platform is Web, iOS or Android
    if (kIsWeb) {
      currentPlatform.value = "isWeb";
    } else {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        currentPlatform.value = "isiOS";
      } else if (Theme.of(context).platform == TargetPlatform.android) {
        currentPlatform.value = "isAndroid";
      }
    }
    // -- check device is Mobile, Tablet or Desktop
    isMobile.value = MediaQuery.of(context).size.width < 600;
    isTablet.value = MediaQuery.of(context).size.width > 600 &&
        MediaQuery.of(context).size.width < 1008;
    isDesktop.value = MediaQuery.of(context).size.width > 1008;
  }

  // -- check device orientation
  void checkOrientation(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      isLandscape(false);
    } else {
      isLandscape(true);
    }
  }

  // -- open keyboard
  void openKeyboard(BuildContext context, FocusNode? focusNode) {
    SystemChannels.textInput.invokeMethod('TextInput.show');
    FocusScope.of(context).requestFocus(focusNode);
  }

  // -- close keyboard
  void closeKeyboard(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
