import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class AddVideoPage extends StatefulWidget {
  String videoUrl;
  @override
  _AddVideoPageState createState() => _AddVideoPageState();
  AddVideoPage({Key key, this.videoUrl}) : super(key: key);
}

class _AddVideoPageState extends State<AddVideoPage> {
  YoutubePlayerController controller ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(controller: controller)
          ],
        ),
      ),
    );
  }
}
