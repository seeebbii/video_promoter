import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:video_promoter/Models/WatchVideo.dart';
import 'package:video_promoter/Models/stateMachine.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:video_promoter/controllers/watchVideoController.dart';
import 'package:video_promoter/utilities/ad_helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  BannerAd _ad;

  // CONNECTION VARIABLES
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectivityResult;

  WatchVideo currentVideo;
  int duration;
  int timerForTimer;
  bool isStarted = false;
  // ignore: non_constant_identifier_names
  int AWARD;

  final userController = Get.put(UserController());
  var watchVideoController = Get.find<WatchVideoController>();

  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: AdListener(
          onAdLoaded: (_) {
            setState(() {});
          },
        ),
        request: AdRequest());
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
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
    if (watchVideoController.isStateChanged.value == true) {
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

              if (_connectivityResult != ConnectivityResult.none) {
                return Column(
                  children: [
                    Container(
                      child: AdWidget(
                        ad: _ad,
                      ),
                      width: _ad.size.width.toDouble(),
                      height: _ad.size.height.toDouble(),
                    ),
                    YoutubePlayer(
                      onReady: () {
                        Future.delayed(Duration(milliseconds: 1300), () {
                          declareTimeValues();
                          setState(() {
                            watchVideoController.isPlayerReady.value = true;
                          });
                        });
                      },
                      controller: watchVideoController.youtubeController.value,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Color.fromRGBO(255, 119, 129, 1),
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
                            child: AWARD == null
                                ? Text("Award: ...")
                                : Text("Award: $AWARD Minutes"),
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
                            : timerForTimer == null
                                ? Text(
                                    "${watchVideoController.curVideo.value.duration}")
                                : Text("$timerForTimer"),
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: !isStarted &&
                                  timerForTimer != null &&
                                  watchVideoController.isPlayerReady.value
                              ? () {
                                  startTimer();
                                  watchVideoController.youtubeController.value
                                      .play();
                                }
                              : null,
                          child: Text("Play"),
                          color: Color.fromRGBO(255, 119, 129, 1),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                try {
                  if (isStarted &&
                      _connectivityResult == ConnectivityResult.none) {
                    setState(() {
                      isStarted = false;
                    });
                  } else {
                    setState(() {
                      watchVideoController.isPlayerReady.value = false;
                    });
                    watchVideoController.youtubeController.value.reset();
                    // startTimer();
                  }
                } finally {
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

  void declareTimeValues() {
    watchVideoController.isTimerRunning.value = true;
    timerForTimer = watchVideoController.curVideo.value.duration * 60;
  }

  void startTimer() {
    setState(() {
      isStarted = true;
    });

    Future.delayed(Duration(milliseconds: 1100), () {});
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
        watchVideoController.curVideo.value.videoId.toString(),
        AWARD,
        view,
        durationWatched,
        watchVideoController);
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
