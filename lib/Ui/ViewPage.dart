import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Models/stateMachine.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewPage extends StatefulWidget {
  YoutubePlayerController controller;
  @override
  _ViewPageState createState() {

    if(StateMachine.Viewinstance == null){
      StateMachine.Viewinstance = this;
    }

    return _ViewPageState();
  }

}

class _ViewPageState extends State<ViewPage> {

  PlayerState _playerState;
  bool _isPlayerReady = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(
            "https://www.youtube.com/watch?v=m_03W6C5fUA"),
        flags: YoutubePlayerFlags(
          autoPlay: true,
          disableDragSeek: true,
          hideControls: false,
        ))..addListener(listener);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(
              controller: widget.controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              aspectRatio: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  onPressed: (){
                    widget.controller.pause();
                  },
                  child: Text("Pause"),
                  color: Colors.red,
                ),
                FlatButton(
                  onPressed: (){
                    widget.controller.play();
                  },
                  child: Text("Play"),
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
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

}
