import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:http/http.dart' as http;
import 'package:video_promoter/Models/VideosModel.dart';
import 'package:video_promoter/controllers/watchVideoController.dart';

class UserController extends GetxController {

  var currentTab = 1.obs;

  var _user = new User().obs;
  var userBal = 0.obs;
  var isVideoLoading = true.obs;

  var userVideos = <VideosModel>[].obs;

  User get user => _user.value;

  void addBalance(int cost){
    _user.value.balance += cost;
    userBal.value +=cost;
  }

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id, name, email, referral, videoWatched;
    int balance;
    id = prefs.getString('id');
    name = prefs.getString('name');
    email = prefs.getString('email');
    referral = prefs.getString('referral');
    videoWatched = prefs.getString("vid_watched");

    String url =
        "https://www.videopromoter.tk/Video_app/getBalance.php?id=$id";
    http.Response response = await http.get(url);
    var test = jsonDecode(response.body);
    balance = int.parse(test['balance']);
    userBal.value = balance;
    User user = new User(
        id: id, name: name, email: email, balance: balance, referral: referral, videoWatched: videoWatched);
    _user.value = user;
  }

  getBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id;
    id = prefs.getString('id');
    String url =
        "https://www.videopromoter.tk/Video_app/getBalance.php?id=$id";
    http.Response response = await http.get(url);
    var test = jsonDecode(response.body);
    userBal.value = int.parse(test['balance']);
  }

  void getMyVideos() {
    isVideoLoading(true);
    Future.delayed(Duration(seconds: 3), () async {
      String Url =
          "https://www.videopromoter.tk/Video_app/getMyVideos.php?id=${user.id}";
      http.Response response = await http.get(Url);
      List test = json.decode(response.body);
      try{
        for (int i = 0; i < test.length; i++) {
          String extractedId = test[i]['link'];

          if(extractedId.contains("https://youtu.be/")){
            extractedId = extractedId.substring(
                extractedId.indexOf('/') + 11, extractedId.length);
          }else{
            extractedId = extractedId.substring(
                extractedId.indexOf('=') + 1, extractedId.length);
          }

          // print("$extractedId");

          VideosModel model = VideosModel(
              test[i]['link'],
              int.parse(test[i]['totalViews']),
              int.parse(test[i]['gotViews']),
              int.parse(test[i]['duration']),
              int.parse(test[i]['durationWatched']),
              extractedId, int.parse(test[i]['vid']));
          userVideos.add(model);
        }
      }
      finally{
        isVideoLoading(false);
      }

    });
  }


  void updateWatchedVideos(String vidId, int cost, int view, int durationWatched, var watchVideoController) async {

    // CHECK IF THE VID ID IS ALREADY PRESENT IN THE USERS WATCHED VIDEO DATABASE
    // String url = "https://www.videopromoter.tk/Video_app/getWatchVideoString.php?id=${user.id}";
    // http.Response watchedByUser = await http.get(url);
    // var test = jsonDecode(watchedByUser.body);
    //
    // String userWatchings = test['vid_watched'];
    // print(userWatchings);
    //
    // if(userWatchings.contains(vidId)){
    //   // Last vid of the database
    //
    //   // Clear all the shared pref watching history as well as watching database
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();
    //   _user.value.videoWatched = "0" ;
    //   prefs.setString("vid_watched", "0");
    //
    //   // UPDATES USER WATCHING
    //   String Url = "https://www.videopromoter.tk/Video_app/vidWatchedByUser.php?id=${user.id}&vid_watched=${_user.value.videoWatched}";
    //   http.Response userWatching = await http.get(Url);
    //   print(userWatching.body);
    //
    //   watchVideoController.getVideo();
    //
    // }else{
      String watchUrl =
          "https://www.videopromoter.tk/Video_app/getWatchVideoString.php?id=${user.id}";
      http.Response watchedByUser = await http.get(watchUrl);
      var variable = jsonDecode(watchedByUser.body);

      String userWatchings = variable['vid_watched'];
      userWatchings+=",$vidId";

      // UPDATES USER WATCHING
      String Url = "https://www.videopromoter.tk/Video_app/vidWatchedByUser.php?id=${user.id}&vid_watched=${userWatchings}";
      http.Response userWatching = await http.get(Url);
      print(userWatching.body);

      // UPDATES VIDEO DETAILS ACCORDINGLY
      String updateVidDetailsUrl = "https://www.videopromoter.tk/Video_app/updateVideoDetails.php?vidId=${vidId}&gotViews=${view}&durationWatched=${durationWatched}";
      http.Response videoDetails = await http.get(updateVidDetailsUrl);
      print(videoDetails.body);

      // ADD AWARD TO THE USER
      addBalance(cost);
      int updateBalaCost =-cost;
      String updateBalance = "https://www.videopromoter.tk/Video_app/updateBalance.php?id=${user.id}&cost=$updateBalaCost";
      http.Response updateBalanceReq = await http.get(updateBalance);
      print(updateBalanceReq.body);
      Get.snackbar("Award received", "${cost} Minutes have been added to your account.", snackPosition: SnackPosition.BOTTOM);

      watchVideoController.getVideo();

    // }

  }



  void addToVideos(VideosModel obj) {
    userVideos.add(obj);
  }

  @override
  // TODO: implement onDelete
  get onDelete => super.onDelete;
}
