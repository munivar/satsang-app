import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satsang/helpers/app_color.dart';
import 'package:satsang/helpers/app_helper.dart';

class AppTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final bool? readOnly;
  final bool? autofocus;
  final int? maxLines;
  final String? hintText;
  final String? errorText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final Widget? prefix;
  final TextEditingController? controller;
  final Color? fillColor;
  final Widget? suffix;
  final String? fontFamily;
  final bool? obscureText;
  final int? maxLength;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  const AppTextField({
    super.key,
    this.height,
    this.width,
    this.readOnly,
    this.autofocus,
    this.maxLines,
    this.hintText,
    this.errorText,
    this.textInputAction,
    this.keyboardType,
    this.contentPadding,
    this.suffixIcon,
    this.suffixIconColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefix,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.maxLength,
    this.fillColor,
    this.decoration,
    this.inputFormatters,
    this.suffix,
    this.fontFamily,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60,
      width: width ?? AppHelper.width(context, 90),
      child: TextField(
        readOnly: readOnly ?? false,
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.text,
        autofocus: autofocus ?? false,
        maxLines: maxLines ?? 1,
        style: TextStyle(
          color: AppColor.fontClr,
          fontSize: AppHelper.font(context, 18),
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
          fontFamily: fontFamily,
        ),
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        obscureText: obscureText ?? false,
        decoration: decoration ??
            InputDecoration(
              counter: const Offstage(),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.borderClr,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.primaryClr,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.borderClr,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              filled: true,
              fillColor: fillColor ?? Colors.transparent,
              hoverColor: Colors.transparent,
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColor.fontHintClr,
                fontSize: AppHelper.font(context, 16),
                letterSpacing: 0.2,
                fontFamily: fontFamily,
              ),
              errorText: errorText,
              prefixIcon: prefixIcon,
              prefix: prefix,
              prefixIconColor: prefixIconColor,
              suffixIcon: suffixIcon,
              suffix: suffix ?? const Text(""),
              suffixIconColor: suffixIconColor,
              contentPadding: contentPadding ??
                  const EdgeInsets.only(left: 20, right: 15, top: 4),
            ),
      ),
    );
  }
}
