import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Models/VideosModel.dart';
import 'package:video_promoter/Ui/AddVideoPage.dart';
import 'package:video_promoter/Ui/ViewMyVideo.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:youtube_video_validator/youtube_video_validator.dart';
import 'package:http/http.dart' as http;

class ChannelPage extends StatefulWidget {
  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  TextEditingController _linkController = TextEditingController();
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    // userController.getMyVideos();
  }

  // set up the AlertDialog
  _displayDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Video Link'.tr),
            content: TextField(
              controller: _linkController,
              decoration: InputDecoration(
                  hintText: "Enter your YouTube video link here".tr),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cancel'.tr),
                onPressed: () {
                  _linkController.clear();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('Add'.tr),
                onPressed: () {
                  _checkValidity();
                },
              )
            ],
          );
        });
  }

  // set up the AlertDialog
  AlertDialog invalid = AlertDialog(
    title: Text("Error!".tr),
    content: Text("The link entered is not valid.".tr),
  );

  _checkValidity() {
    String url = _linkController.text.toString();
    isValid = YoutubeVideoValidator.validateUrl(url);
    if (isValid) {
      _linkController.clear();
      Navigator.of(context).pop();
      Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
        return AddVideoPage(
          videoUrl: url,
        );
      }));
    } else {
      _linkController.clear();
      Navigator.of(context).pop();
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return invalid;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _displayDialog(context);
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
        ),
        body: GetX<UserController>(
            init: UserController(),
            builder: (controller) {
              if (controller.isVideoLoading.value) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return controller.userVideos.length > 0
                  ? ListView.builder(
                      cacheExtent: 9000,
                      shrinkWrap: true,
                      itemCount: controller.userVideos.length,
                      padding: new EdgeInsets.all(8.0),
                      itemBuilder: (_, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(new MaterialPageRoute(builder: (context) {
                              return ViewMyVideo(
                                  controller.userVideos[index].link,
                                  controller.userVideos[index].totalViews,
                                  controller.userVideos[index].gotView,
                                  controller.userVideos[index].duration,
                                  controller.userVideos[index].durationWatched,
                                  index,
                                  controller.userVideos[index].vidId);
                            }));
                          },
                          child: Card(
                              shadowColor: Colors.black,
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.black,
                              child: controller.userVideos[index]),
                        );
                      })
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: Text("No video for promotion".tr)));
            }));
  }
}
