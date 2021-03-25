import 'dart:convert';

import 'package:get/get.dart';
import 'package:video_promoter/Models/WatchVideo.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchVideoController extends GetxController{

  var _curVideo = WatchVideo().obs;

  WatchVideo get curVideo => _curVideo.value;

  var youtubeController = YoutubePlayerController(initialVideoId: "").obs;

  var videoIsLoading = true.obs;


   void getVideo() async {
     try{
       videoIsLoading(true);
       String url = "http://www.videopromoter.tk/Video_app/viewRandomVideo.php?tested=1,5";
       http.Response response = await http.get(url);
       var test = json.decode(response.body);
       WatchVideo obj = WatchVideo(link: test['link'], videoId: int.parse(test['vid']) , email:test['email'], name: test['name'], uploaderId: int.parse(test['id']), duration: int.parse(test['duration']));
       _curVideo.value = obj;

       youtubeController.value =  YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId("${_curVideo.value.link}"), flags: YoutubePlayerFlags(
           autoPlay: true,
         hideControls: false
       ));

     }finally{
       videoIsLoading(false);
     }
  }

}