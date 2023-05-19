import 'package:flutter/material.dart';
import 'package:satsang/helpers/app_helper.dart';
import 'package:simple_animations/simple_animations.dart';

class AppLoaderWidget extends StatelessWidget {
  final Color? color;
  const AppLoaderWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoaderWidget(delay: const Duration(milliseconds: 100), color: color),
          AppHelper.sizedBox(context, null, 1),
          LoaderWidget(delay: const Duration(milliseconds: 200), color: color),
          AppHelper.sizedBox(context, null, 1),
          LoaderWidget(delay: const Duration(milliseconds: 300), color: color),
        ],
      ),
    );
  }
}

class LoaderWidget extends StatelessWidget {
  final Duration? delay;
  final Color? color;
  const LoaderWidget({super.key, required this.delay, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: Control.mirror,
      tween: Tween(begin: 3.0, end: 20.0),
      duration: const Duration(milliseconds: 400),
      delay: delay ?? const Duration(milliseconds: 25),
      curve: Curves.easeInOut,
      startPosition: 0.5,
      builder: (context, value, child) {
        return Container(
          width: 4,
          height: value,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      },
    );
  }
}
