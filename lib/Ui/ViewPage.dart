import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Models/WatchVideo.dart';
import 'package:video_promoter/Models/stateMachine.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

import '../Models/WatchVideo.dart';

class ViewPage extends StatefulWidget {
  YoutubePlayerController controller;

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentVideo == null) {
    } else {
      int endTime =
          DateTime.now().millisecondsSinceEpoch + 1000 * currentVideo.duration;
      /*do{

    }while(currentVideo.link == "" && currentVideo.duration < 1);*/
      widget.controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(currentVideo.link),
          flags: YoutubePlayerFlags(
            autoPlay: true,
            disableDragSeek: true,
            hideControls: false,
          ))
        ..addListener(listener);

      setState(() {
        _start = currentVideo.duration;
      });

      if (widget.controller.hasListeners) {
        startTimer();
      }
    }

    return Scaffold(
      body: FutureBuilder(
        future: getVideo(),
        builder: (context, AsyncSnapshot<WatchVideo> snapshot) {
<<<<<<< HEAD
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
=======
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Center(
                child: Text("No Data yet"),
              );
            }else{
              return Container();
            }
          }else{
            if(snapshot.data != null){
              return Column(
>>>>>>> 55d1c3d79825201dcf80b83a621f9fce9e810643
                children: [
                  YoutubePlayer(
                    onReady: () {
                      setState(() {
                        _isPlayerReady = true;
                      });
                    },
                    controller: widget.controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                    aspectRatio: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        onPressed: () {
                          widget.controller.pause();
                        },
                        child: Text("Pause"),
                        color: Colors.red,
                      ),
                      _start == null
                          ? CircularProgressIndicator()
                          : Text("$_start"),
                      FlatButton(
                        onPressed: () {
                          widget.controller.play();
                        },
                        child: Text("Play"),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
<<<<<<< HEAD
              ),
            );
            // return Center(
            //   child: Text("Data has been loaded."),
            // );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
=======
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }

>>>>>>> 55d1c3d79825201dcf80b83a621f9fce9e810643
          }
          // return Center(
          //   child: Text("Data has been loaded."),
          // );
        },
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void listener() {
    if (_isPlayerReady && mounted && !widget.controller.value.isFullScreen) {
      setState(() {
        _playerState = widget.controller.value.playerState;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<WatchVideo> getVideo() async {
    String url =
        "https://appvideopromo.000webhostapp.com/VideoApp/viewRandomVideo.php?tested=1";
    http.Response response = await http.get(url);

    var test = json.decode(response.body);
    WatchVideo obj = WatchVideo(
        test['link'],
        int.parse(test['vid']),
        test['email'],
        test['name'],
        int.parse(test['id']),
        int.parse(test['duration']));

    setState(() {
      currentVideo = obj;
    });
    return obj;
  }
}
