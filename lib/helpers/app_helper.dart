import 'package:flutter/material.dart';
import 'package:satsang/helpers/app_images.dart';

class AppHelper {
  // -- sized box
  static sizedBox(BuildContext context, double? height, double? width) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height == null ? 0.0 : screenHeight * height / 100,
      width: width == null ? 0.0 : screenWidth * width / 100,
    );
  }

  // -- responsive font
  static font(BuildContext context, double fontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (fontSize / 3.8) / 100;
  }

  // -- responsive height
  static height(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * height / 100;
  }

  // -- responsive width
  static width(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * width / 100;
  }

  // -- default image
  static defaultImage(double height, double width) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(AppImages.noImage),
      ),
    );
  }
}
