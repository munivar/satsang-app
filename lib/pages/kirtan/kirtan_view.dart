import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/helpers/app_color.dart';
import 'package:satsang/helpers/app_helper.dart';
import 'package:satsang/helpers/app_images.dart';
import 'package:satsang/pages/base_contrl.dart';
import 'package:satsang/pages/kirtan/kirtan_contrl.dart';
import 'package:satsang/widgets/app_text.dart';

class KirtanView extends StatelessWidget {
  KirtanView({super.key});
  final baseContrl = Get.find<BaseController>();
  final kirtanContrl = Get.put(KirtanController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbarLayout(context),
        body: mainLayout(context),
      ),
    );
  }

  appbarLayout(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryClr,
      toolbarHeight: 60,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        height: 60,
        padding:
            EdgeInsets.symmetric(horizontal: AppHelper.width(context, 2.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppImages.backIcon,
                    color: Colors.white,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ),
            AppText(
              text: "કીર્તન",
              fontSize: AppHelper.font(context, 20),
              fontColor: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            AppHelper.sizedBox(context, null, 8),
          ],
        ),
      ),
    );
  }

  mainLayout(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColor.backgroundClr,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              readerWidget(context),
              AppHelper.sizedBox(context, 2, null),
              playerContrl(context),
              AppHelper.sizedBox(context, 2, null),
            ],
          ),
        ));
  }

  readerWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/bg.jpeg",
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        Obx(() {
          return LyricsReader(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            model: kirtanContrl.lyricModel,
            position: kirtanContrl.playProgress.value,
            lyricUi: kirtanContrl.lyricUI,
            playing: kirtanContrl.playing.value,
            size: Size(double.infinity, AppHelper.height(context, 50)),
            emptyBuilder: () => Center(
              child: Text(
                "No lyrics",
                style: kirtanContrl.lyricUI.getOtherMainTextStyle(),
              ),
            ),
          );
        })
      ],
    );
  }

  playerContrl(BuildContext context) {
    return Column(
      children: [
        AppHelper.sizedBox(context, 2, null),
        Obx(() {
          return AppText(
            text: "Progress:${kirtanContrl.sliderProgress.value}",
            fontSize: 18,
            fontColor: Colors.grey,
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: kirtanContrl.startTime.value,
                    fontSize: 16,
                  ),
                );
              }),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: kirtanContrl.endTime.value,
                    fontSize: 16,
                  ),
                );
              })
            ],
          ),
        ),
        Obx(() {
          return kirtanContrl.sliderProgress.value < kirtanContrl.maxValue.value
              ? Slider(
                  min: 0,
                  max: kirtanContrl.maxValue.value,
                  label: kirtanContrl.sliderProgress.value.toString(),
                  value: kirtanContrl.sliderProgress.value,
                  activeColor: AppColor.primaryClr,
                  inactiveColor: Colors.grey,
                  onChanged: (double value) {
                    kirtanContrl.sliderProgress.value = value;
                  },
                  onChangeStart: (double value) {
                    kirtanContrl.isTap.value = true;
                  },
                  onChangeEnd: (double value) {
                    kirtanContrl.isTap.value = false;
                    kirtanContrl.playProgress.value = value.toInt();
                    kirtanContrl.audioPlayer
                        .seek(Duration(milliseconds: value.toInt()));
                  },
                )
              : Container();
        }),
        AppHelper.sizedBox(context, 3, null),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () async {
                  kirtanContrl.audioPlayer
                      .setAsset("assets/bolya_shree_hari.m4a");
                  await kirtanContrl.audioPlayer.play();
                  kirtanContrl.playing.value = true;
                  kirtanContrl.audioPlayer.positionStream.listen((event) {
                    kirtanContrl.playProgress.value = event.inMilliseconds;
                    kirtanContrl.sliderProgress.value =
                        event.inMilliseconds.toDouble();
                    kirtanContrl.startTime.value =
                        "${event.inHours}:${event.inMinutes}:${event.inSeconds}";
                  });
                  kirtanContrl.audioPlayer.playbackEventStream.listen((event) {
                    if (kirtanContrl.isTap.value) return;
                    kirtanContrl.maxValue.value =
                        event.bufferedPosition.inMilliseconds.toDouble();
                    kirtanContrl.endTime.value =
                        "${event.bufferedPosition.inHours}:${event.bufferedPosition.inMinutes}:${event.bufferedPosition.inSeconds}";
                  });
                  kirtanContrl.audioPlayer.playerStateStream.listen((state) {
                    kirtanContrl.playing.value = state.playing;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppText(
                    text: "Play",
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            AppHelper.sizedBox(context, null, 5),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () async {
                  await kirtanContrl.audioPlayer.stop();
                },
                borderRadius: BorderRadius.circular(10),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppText(
                    text: "Stop",
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}