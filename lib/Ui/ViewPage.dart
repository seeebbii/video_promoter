import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Models/WatchVideo.dart';
import 'package:video_promoter/Models/stateMachine.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:video_promoter/controllers/watchVideoController.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

import '../Models/WatchVideo.dart';

class ViewPage extends StatefulWidget {
  @override
  _ViewPageState createState() {
    if (StateMachine.Viewinstance == null) {
      StateMachine.Viewinstance = this;
    }

    return _ViewPageState();
  }
}

class _ViewPageState extends State<ViewPage> {
  PlayerState _playerState;

  WatchVideo currentVideo;
  PausableTimer pausableTimer;
  int duration;
  Timer _timer;

  var watchVideoController = Get.find<WatchVideoController>();
  final userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    // videoWatched();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetX<WatchVideoController>(
            init: WatchVideoController(),
            builder: (controller) {
              if (controller.videoIsLoading.value) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Column(
                children: [
                  YoutubePlayer(
                    onReady: () {
                      startTimer();
                      watchVideoController.isPlayerReady.value = true;
                    },
                    controller: watchVideoController.youtubeController.value,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                    bufferIndicator: Center(
                      child: CircularProgressIndicator(),
                    ),
                    aspectRatio: 0.8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        onPressed: () {
                          watchVideoController.youtubeController.value.pause();
                          // _timer.cancel();
                        },
                        child: Text("Pause"),
                        color: Colors.red,
                      ),
                      watchVideoController.curVideo.value.duration == null
                          ? CircularProgressIndicator()
                          : Text(
                              "${watchVideoController.curVideo.value.duration}"),
                      FlatButton(
                        onPressed: () {
                          watchVideoController.youtubeController.value.play();
                        },
                        child: Text("Play"),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }

  void startTimer() {
    watchVideoController.isTimerRunning.value = true;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (watchVideoController.curVideo.value.duration < 1) {
            timer.cancel();
            if ((watchVideoController.isStateChanged.value == true)) {
              timer.cancel();
            }
          } else {
            watchVideoController.curVideo.value.duration =
                watchVideoController.curVideo.value.duration - 1;
          }
        },
      ),
    );
  }

  void videoWatched() {
    userController.updateWatchedVideos(
        watchVideoController.curVideo.value.videoId.toString());
  }

  @override
  void dispose() {
    watchVideoController.youtubeController.value.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
