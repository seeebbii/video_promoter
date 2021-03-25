import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;


class ViewMyVideo extends StatefulWidget {
  String link;
  int totalViews;
  int gotView;
  int duration;
  int durationWatched;
  int index;
  int vidId;

  ViewMyVideo(this.link, this.totalViews, this.gotView, this.duration,
      this.durationWatched, this.index, this.vidId);

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

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video ${widget.index + 1}"),
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
            child: userController.user.balance == null
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
                    "${userController.user.balance}",
                    style:
                        TextStyle(fontSize: 20.5, fontWeight: FontWeight.w400),
                  ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(
              controller: controller,
            ),
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
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
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
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
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
                onPressed: deleteVideo,
                child: Text(
                  "DELETE",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'NOTE: YouTube needs 72 hours to update views from third party apps. So please wait at least 72 hours before checking.'),
            ),
          ],
        ),
      ),
    );
  }

  void deleteVideo() async {
    String url = "http://appvideopromo.000webhostapp.com/VideoApp/deleteVideo.php?vidId=${widget.vidId}";
    http.Response response = await http.get(url);
    if(response.body.contains("Video Deleted successfully")){
      Fluttertoast.showToast(
          msg: "Video deleted successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);

      userController.userVideos.removeAt(widget.index);

      Navigator.of(context).pop();
    }else{
      Fluttertoast.showToast(
          msg: "Error deleting video!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

}
