import 'package:flutter/material.dart';
import 'package:satsang/helpers/app_color.dart';
import 'package:satsang/helpers/app_helper.dart';

class AppButtonBox extends StatelessWidget {
  final Widget child;
  final bool isClickable;
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
  const AppButtonBox({
    super.key,
    this.backgroundColor,
    this.onTap,
    this.decoration,
    required this.isClickable,
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
      height: height ?? 48,
      width: width ?? AppHelper.width(context, 90),
      padding: padding,
      decoration: decoration ??
          BoxDecoration(
            color: containerColor ?? AppColor.primaryClr,
            border: boxBorder ??
                Border.all(
                  color: AppColor.backgroundClr.withOpacity(0.50),
                  width: 1,
                ),
            borderRadius: containerBorderRadius ?? BorderRadius.circular(25),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    spreadRadius: 0,
                  )
                ],
          ),
      child: isClickable == true
          ? Material(
              color: backgroundColor ?? Colors.transparent,
              borderRadius: borderRadius ?? BorderRadius.circular(25),
              child: InkWell(
                onTap: onTap ?? () {},
                borderRadius: BorderRadius.circular(25),
                child: child,
              ),
            )
          : child,
    );
  }
}
