import 'package:flutter/material.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class ViewMyVideo extends StatefulWidget {

  String link;
  int totalViews;
  int gotView;
  int duration;
  int durationWatched;
  User user;
  int index;


  ViewMyVideo(this.link, this.totalViews, this.gotView, this.duration,
      this.durationWatched, this.user, this.index);

  @override
  _ViewMyVideoState createState() => _ViewMyVideoState();
}

class _ViewMyVideoState extends State<ViewMyVideo> {
  YoutubePlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.link),
        flags: YoutubePlayerFlags(autoPlay: true));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video ${widget.index+1}"),
        backgroundColor: Colors.red,
        actions: [
          Image.asset(
            'assets/logo/clock.png',
            width: 22,
            color: Colors.white,
          ),
          FlatButton(
            textColor: Colors.white,
            minWidth: 15,
            onPressed: () {},
            child: widget.user.balance == null
                ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                backgroundColor: Color(0xFFF1959B),
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.red.shade700),
              ),
            )
                : Text(
              "${widget.user.balance}",
              style: TextStyle(fontSize: 20.5, fontWeight: FontWeight.w400),
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(controller: controller,),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Seen by ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${widget.gotView} / ${widget.totalViews}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade700
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Duration watched",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${widget.durationWatched}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade700
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: RaisedButton(
                elevation: 5,
                color: Colors.red,
                onPressed: (){
                },
                child: Text(
                  "DELETE",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
