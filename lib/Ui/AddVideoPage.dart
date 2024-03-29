import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_promoter/Models/VideosModel.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddVideoPage extends StatefulWidget {
  String videoUrl;

  @override
  _AddVideoPageState createState() => _AddVideoPageState();

  AddVideoPage({Key key, this.videoUrl}) : super(key: key);
}

class _AddVideoPageState extends State<AddVideoPage> {
  YoutubePlayerController controller;
  TextEditingController viewsController;
  TextEditingController minController;
  bool uploading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl),
        flags: YoutubePlayerFlags(autoPlay: true));
  }

  final userController = Get.find<UserController>();
  int selectedViewCount = 0;
  int selectedMinCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Video".tr),
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
            YoutubePlayer(controller: controller),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Number of Views".tr,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                      width: 80.0,
                      height: 50,
                      child: TextField(
                          onChanged: (String value) {
                            setState(() {
                              selectedViewCount = int.parse(value);
                            });
                          },
                          controller: viewsController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration:
                              InputDecoration(hintText: "Views Count".tr),
                          style: TextStyle(
                            fontSize: 12,
                            height: 2.0,
                            color: Colors.black,
                          )))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time Duration (Min)".tr,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                      width: 80.0,
                      height: 50,
                      child: TextField(
                          onChanged: (String value) {
                            setState(() {
                              selectedMinCount = int.parse(value);
                            });
                          },
                          controller: minController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(hintText: "Min Count".tr),
                          style: TextStyle(
                            fontSize: 12,
                            height: 2.0,
                            color: Colors.black,
                          )))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Cost".tr,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${selectedViewCount * selectedMinCount}",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )
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
                onPressed: !uploading ? validate : null,
                child: !uploading ? Text(
                  "DONE",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ) : Container(
                  height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(252, 222, 214, 1),
                      strokeWidth: 3.2,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'NOTE: YouTube needs 72 hours to update views from third party apps. So please wait at least 72 hours before checking.'
                      .tr
                      .tr),
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog invalid = AlertDialog(
    title: Text("Insufficient fund!".tr),
    content: Text("Watch more videos to earn.".tr),
  );

  AlertDialog invalidCount = AlertDialog(
    title: Text("View count or Min count cannot be 0".tr),
    content: Text("Values should be greater than 0".tr),
  );

  void toggleUploading(bool val){
    setState(() {
      uploading = val;
    });
  }

  void validate() async {

    int totalCost = selectedViewCount * selectedMinCount;

    if (userController.user.balance >= totalCost) {
      if (selectedMinCount > 0 && selectedViewCount > 0) {

        toggleUploading(true);

        // ignore: non_constant_identifier_names
        String URL =
            'https://www.videopromoter.tk/Video_app/addVideo.php?email=${userController.user.email}&name=${userController.user.name}&id=${userController.user.id}&link=${widget.videoUrl}&totalViews=$selectedViewCount&gotViews=0&duration=$selectedMinCount&durationWatched=0';
        http.Response response = await http.get(URL);
        if (response.body == "Video added successfully".tr) {
          String extractedId = "";
          if (widget.videoUrl.contains("https://youtu.be/")) {
            extractedId = widget.videoUrl.substring(
                widget.videoUrl.indexOf('/') + 11, widget.videoUrl.length);
          } else {
            extractedId = widget.videoUrl.substring(
                widget.videoUrl.indexOf('=') + 1, widget.videoUrl.length);
          }

          VideosModel model = VideosModel(widget.videoUrl, selectedViewCount, 0,
              selectedMinCount, 0, extractedId, null);
          userController.addToVideos(model);



          // Deduct balance from the server
          // ignore: non_constant_identifier_names
          String URL =
              'https://www.videopromoter.tk/Video_app/updateBalance.php?id=${userController.user.id}&cost=$totalCost';
          userController.user.balance = userController.user.balance - totalCost;
          userController.userBal -= totalCost;
          http.Response response = await http.get(URL);
          toggleUploading(false);
          print(response.body);
          Navigator.of(context).pop();
          Get.snackbar("Video added successfully!", "", snackPosition: SnackPosition.BOTTOM);
        }if(response.body == "Video already exists"){
          toggleUploading(false);
          Get.snackbar("Video already exists!", "Video cannot be recurring", snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        // toggleUploading(false);
        // COUNT < 0
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return invalidCount;
          },
        );
      }
    } else {
      // toggleUploading(false);
      // Not sufficient stuff
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return invalid;
        },
      );
    }
  }
}
