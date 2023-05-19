import 'package:flutter/material.dart';
import 'package:satsang/helpers/app_color.dart';

class AppShadowBox extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final Color? containerColor;
  final Color? backgroundColor;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? boxBorder;
  final Function()? onTap;
  final BorderRadiusGeometry? containerBorderRadius;
  final BorderRadiusGeometry? borderRadius;
  const AppShadowBox({
    super.key,
    this.backgroundColor,
    this.onTap,
    this.decoration,
    required this.child,
    this.padding,
    this.height,
    this.width,
    this.boxShadow,
    this.containerColor,
    this.boxBorder,
    this.containerBorderRadius,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: decoration ??
          BoxDecoration(
            color: containerColor ?? Colors.white,
            border: boxBorder ??
                Border.all(
                  color: AppColor.borderClr.withOpacity(0.50),
                  width: 1,
                ),
            borderRadius: containerBorderRadius ??
                const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    spreadRadius: 0,
                  )
                ],
          ),
      child: child,
    );
  }
}
