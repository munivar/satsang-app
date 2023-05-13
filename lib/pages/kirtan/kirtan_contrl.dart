import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:satsang/helpers/app_const.dart';

class KirtanController extends GetxController {
  final audioPlayer = AudioPlayer();
  RxDouble sliderProgress = 0.0.obs;
  RxInt playProgress = 0.obs;
  RxDouble maxValue = 0.0.obs;
  RxString startTime = "".obs;
  RxString endTime = "".obs;
  var lyricUI = UINetease();
  RxBool isTap = false.obs;
  RxBool playing = false.obs;
  var lyricModel =
      LyricsModelBuilder.create().bindLyricToMain(Const.normalLyric).getModel();

  @override
  void onInit() {
    lyricUI.highlightedColor = Colors.amber;
    lyricUI.defaultSize = 24;
    lyricUI.defaultExtSize = 24;
    lyricUI.lyricAlign = LyricAlign.CENTER;
    lyricUI.lyricBaseLine = LyricBaseLine.EXT_CENTER;
    super.onInit();
  }
}
