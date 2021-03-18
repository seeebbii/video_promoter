import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Models/WatchVideo.dart';
import 'package:video_promoter/Models/stateMachine.dart';
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
  bool _isPlayerReady = false;
  WatchVideo currentVideo;
  Timer _timer;
  int _start;

  final watchVideoController = Get.put(WatchVideoController());

  @override
  void initState() {
    super.initState();
    watchVideoController.getVideo();
  }

  @override
  Widget build(BuildContext context) {

    // widget.controller = YoutubePlayerController(
    //     initialVideoId: YoutubePlayer.convertUrlToId(watchVideoController.curVideo.link),
    //     flags: YoutubePlayerFlags(
    //       autoPlay: true,
    //       disableDragSeek: true,
    //       hideControls: false,
    //     ))
    //   ..addListener(listener);

    // if (watchVideoController.curVideo == null) {
    // } else {
    //   int endTime =
    //       DateTime.now().millisecondsSinceEpoch + 1000 * watchVideoController.curVideo.duration;
    //   /*do{
    //
    // }while(currentVideo.link == "" && currentVideo.duration < 1);*/
    //
    //
    //   setState(() {
    //     _start = watchVideoController.curVideo.duration;
    //   });
    //
    //   if (widget.controller.hasListeners) {
    //     startTimer();
    //   }
    // }


    return Scaffold(
      body: GetX<WatchVideoController>(
        init: WatchVideoController(),
        builder: (controller) {
          if (controller.videoIsLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(controller.curVideo.isBlank){
            controller.getVideo();
          }
          return Column(
            children: [
              YoutubePlayer(
                onReady: () {
                  startTimer();
                  setState(() {
                    _isPlayerReady = true;
                  });
                },
                controller: watchVideoController.youtubeController.value,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
                aspectRatio: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: () {
                      watchVideoController.youtubeController.value.pause();
                    },
                    child: Text("Pause"),
                    color: Colors.red,
                  ),
                  watchVideoController.curVideo.duration == null
                      ? CircularProgressIndicator()
                      : Text("${watchVideoController.curVideo.duration}"),
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
        }
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (watchVideoController.curVideo.duration < 1) {
            timer.cancel();
          } else {
            watchVideoController.curVideo.duration = watchVideoController.curVideo.duration - 1;
          }
        },
      ),
    );
  }


  @override
  void dispose() {
    watchVideoController.youtubeController.value.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}
