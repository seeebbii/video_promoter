import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewPage extends StatefulWidget {
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  YoutubePlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(
            "https://www.youtube.com/watch?v=FUiu-cdu6mA"),
        flags: YoutubePlayerFlags(
          controlsVisibleAtStart: true,
          autoPlay: true,
          disableDragSeek: true,
          hideControls: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              aspectRatio: 1,
            ),
            FlatButton(
              onPressed: (){
                controller.pause();
              },
              child: Text("Pause"),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    controller.pause();
  }
}
