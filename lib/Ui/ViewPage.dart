import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

  // CONNECTION VARIABLES
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectivityResult;

  WatchVideo currentVideo;
  int duration;
  Timer _timer;
  int timerForTimer;
  bool isStarted = false;
  int AWARD;

  final userController = Get.put(UserController());
  var watchVideoController = Get.find<WatchVideoController>();


  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      setState(() {
        _connectivityResult = result;
      });
    });
    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);


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

              // if(controller.curVideo.value.isBlank){
              //   return Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height,
              //     child: Center(
              //       child: Text("No video found"),
              //     ),
              //   );
              // }

              if(_connectivityResult != ConnectivityResult.none){
                return Column(
                  children: [
                    YoutubePlayer(
                      onReady: () {
                        Future.delayed(Duration(milliseconds: 1500), (){
                          declareTimeValues();
                          setState(() {
                            watchVideoController.isPlayerReady.value = true;
                          });
                        });

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
                          onPressed: !isStarted && timerForTimer != null && watchVideoController.isPlayerReady.value ?  () {
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
              }else{

                try{
                  if(isStarted && _connectivityResult == ConnectivityResult.none){
                    setState(() {
                      isStarted = false;
                    });
                  }else{
                    setState(() {
                      watchVideoController.isPlayerReady.value = false;
                    });
                    watchVideoController.youtubeController.value.reset();
                    // startTimer();
                  }
                }finally{
                  // ignore: control_flow_in_finally
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text("No internet connection"),
                    ),
                  );
                }
              }


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



    Future.delayed(Duration(milliseconds: 1200 ), (){
      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
            (Timer timer) => setState(
              () {
            if (timerForTimer < 1 || isStarted == false) {
              timer.cancel();
              isStarted = true;
            } if(timerForTimer == 0){
              //iterate the video,  dispose the youtube controller and initialize a new one
              videoWatched();
            } else {
              timerForTimer = timerForTimer - 1;
            }
          },
        ),
      );
    });



  }

  void stop() {
    setState(() {
      isStarted = false;
    });
  }

  void videoWatched() {

    int view = 1;
    int durationWatched = watchVideoController.curVideo.value.duration;
    isStarted = false;
    setState(() {
      watchVideoController.isPlayerReady.value = false;
    });
    watchVideoController.youtubeController.value.reset();
    userController.updateWatchedVideos(
        watchVideoController.curVideo.value.videoId.toString(), AWARD , view, durationWatched, watchVideoController);
    watchVideoController.youtubeController.value.reload();
  }

  @override
  void dispose() {
    watchVideoController.youtubeController.value.dispose();
    _connectivitySubscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}
