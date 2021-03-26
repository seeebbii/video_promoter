import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:http/http.dart' as http;
import 'package:video_promoter/Models/VideosModel.dart';

class UserController extends GetxController {

  var currentTab = 1.obs;

  var _user = new User().obs;
  var userBal = 0.obs;
  var isVideoLoading = true.obs;

  var userVideos = <VideosModel>[].obs;

  User get user => _user.value;

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


  void updateWatchedVideos(String vidId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _user.value.videoWatched += ",${vidId}" ;
    prefs.setString("vid_watched", _user.value.videoWatched);

    String Url =
        "https://www.videopromoter.tk/Video_app/vidWatchedByUser.php?id=${user.id}&vid_watched=${_user.value.videoWatched}";
    http.Response response = await http.get(Url);
    print(response.body);
  }

  void addToVideos(VideosModel obj) {
    userVideos.add(obj);
  }

  @override
  // TODO: implement onDelete
  get onDelete => super.onDelete;
}
