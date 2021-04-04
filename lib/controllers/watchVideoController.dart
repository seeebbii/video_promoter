import 'dart:convert';

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
      String userID = prefs.getString('id');

      String watchUrl =
          "https://www.videopromoter.tk/Video_app/getWatchVideoString.php?id=$userID";
      http.Response watchedByUser = await http.get(watchUrl);
      var variable = jsonDecode(watchedByUser.body);

      String userWatchings = variable['vid_watched'];
      print(userWatchings);

      String url =
          "https://www.videopromoter.tk/Video_app/viewRandomVideo.php?tested=$userWatchings";
      http.Response response = await http.get(url);
      var test = json.decode(response.body);
      print(response.body);

      if (response.body.contains("null")) {
        // UPDATES USER WATCHING
        // ignore: non_constant_identifier_names
        String url =
            "https://www.videopromoter.tk/Video_app/viewRandomVideo.php?tested=0";
        http.Response response = await http.get(url);
        var again = json.decode(response.body);

        WatchVideo obj = WatchVideo(
            link: again['link'],
            videoId: int.parse(again['vid']),
            email: again['email'],
            name: again['name'],
            uploaderId: int.parse(again['id']),
            duration: int.parse(again['duration']));
        curVideo.value = obj;
      } else {
        WatchVideo obj = WatchVideo(
            link: test['link'],
            videoId: int.parse(test['vid']),
            email: test['email'],
            name: test['name'],
            uploaderId: int.parse(test['id']),
            duration: int.parse(test['duration']));
        curVideo.value = obj;
      }

      youtubeController.value = YoutubePlayerController(
          initialVideoId:
              YoutubePlayer.convertUrlToId("${curVideo.value.link}"),
          flags: YoutubePlayerFlags(
              autoPlay: false,
              forceHD: false,
              disableDragSeek: true,
              controlsVisibleAtStart: true,
              hideControls: true));
    } finally {
      videoIsLoading(false);
    }
  }
}
