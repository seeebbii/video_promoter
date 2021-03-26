import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/WatchVideo.dart';
import 'package:http/http.dart' as http;
import 'package:video_promoter/controllers/userController.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchVideoController extends GetxController {
  var curVideo = WatchVideo().obs;


  var youtubeController = YoutubePlayerController(initialVideoId: "").obs;

  var videoIsLoading = true.obs;
  var isPlayerReady = false.obs;

  var userController = Get.find<UserController>();

  var isTimerRunning = false.obs;
  var isStateChanged = false.obs;


  void getVideo() async {
    try {
      videoIsLoading(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String watchedVid = prefs.getString("vid_watched");
      String url =
          "https://www.videopromoter.tk/Video_app/viewRandomVideo.php?tested=$watchedVid";
      http.Response response = await http.get(url);
      var test = json.decode(response.body);
      WatchVideo obj = WatchVideo(
          link: test['link'],
          videoId: int.parse(test['vid']),
          email: test['email'],
          name: test['name'],
          uploaderId: int.parse(test['id']),
          duration: int.parse(test['duration']));
      curVideo.value = obj;

      youtubeController.value = YoutubePlayerController(
          initialVideoId:
              YoutubePlayer.convertUrlToId("${curVideo.value.link}"),
          flags: YoutubePlayerFlags(
              autoPlay: true,
              forceHD: true,
              disableDragSeek: true,
              controlsVisibleAtStart: true,
              hideControls: true));
    } finally {
      videoIsLoading(false);
    }
  }
}
