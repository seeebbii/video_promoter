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
  int timerForTimer;
  bool isStarted = false;
  int AWARD;

  var watchVideoController = Get.find<WatchVideoController>();
  final userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    // videoWatched();
  }

  @override
  Widget build(BuildContext context) {

    if(watchVideoController.isStateChanged.value == true) {
      stop();
    }
    // if(watchVideoController.isStateChanged.value == false && watchVideoController.counterOfTimeStarted.value > 1){
    //   startTimer();
    // }

    return Scaffold(
      body: SingleChildScrollView(
        child: GetX<WatchVideoController>(
            init: WatchVideoController(),
            builder: (controller) {
              AWARD = controller.curVideo.value.duration;
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
                      declareTimeValues();
                      startTimer();
                      setState(() {
                        watchVideoController.counterOfTimeStarted.value+=1;
                      });
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
                      Card(
                        child: Container(
                          child: AWARD == null ? Text("Award: ...") :Text("Award: ${AWARD} Minutes"),
                        ),
                      ),
                      // FlatButton(
                      //   onPressed: () {
                      //     watchVideoController.youtubeController.value.pause();
                      //     stop();
                      //     // _timer.cancel();
                      //   },
                      //   child: Text("Pause"),
                      //   color: Colors.red,
                      // ),
                      watchVideoController.curVideo.value.duration == null
                          ? CircularProgressIndicator()
                          : timerForTimer == null ?  Text(
                              "${watchVideoController.curVideo.value.duration}") : Text(
                          "${timerForTimer}"),
                      FlatButton(
                        onPressed: !isStarted ? () {
                          watchVideoController.youtubeController.value.play();
                          startTimer();
                        } : null,
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


  void declareTimeValues(){

    watchVideoController.isTimerRunning.value = true;
    timerForTimer = watchVideoController.curVideo.value.duration * 60;
  }

  void startTimer() {
    setState(() {
      isStarted = true;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (timerForTimer < 1 || isStarted == false) {
            timer.cancel();
            isStarted = true;
          } else {
            timerForTimer = timerForTimer - 1;
          }
        },
      ),
    );
  }

  void stop() {
    setState(() {
      isStarted = false;
    });
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
