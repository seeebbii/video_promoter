import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;


// ignore: must_be_immutable
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
  bool deleting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.link),
        flags: YoutubePlayerFlags(autoPlay: true,));
  }

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video ${widget.index + 1}"),
        backgroundColor: Color.fromRGBO(255, 119, 129, 1),
        actions: [
          Image.asset(
            'assets/logo/clock.png',
            width: 22,
            color: Colors.white,
          ),
          // ignore: deprecated_member_use
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
                          Color.fromRGBO(255, 119, 129, 1)),
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
              // ignore: deprecated_member_use
              title: RaisedButton(
                elevation: 5,
                color: Color.fromRGBO(255, 119, 129, 1),
                onPressed: !deleting ? deleteVideo : null,
                child: !deleting ? Text(
                  "DELETE",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ) : Container(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(255, 119, 129, 1),
                    strokeWidth: 3.2,
                  ),
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
    setState(() {
      deleting = true;
    });
    String url = "https://www.videopromoter.tk/Video_app/deleteVideo.php?vidId=${widget.vidId}";
    http.Response response = await http.get(url);
    if(response.body.contains("Video Deleted successfully")){


      userController.userVideos.removeAt(widget.index);

      Navigator.of(context).pop();
      Get.snackbar("Video deleted successfully!","", snackPosition: SnackPosition.BOTTOM);
    }else{
      setState(() {
        deleting = false;
      });
      Get.snackbar("Error deleting video!","", snackPosition: SnackPosition.BOTTOM);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}
