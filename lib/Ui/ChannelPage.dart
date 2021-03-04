import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Models/VideosModel.dart';
import 'package:video_promoter/Ui/AddVideoPage.dart';
import 'package:video_promoter/Ui/ViewMyVideo.dart';
import 'package:youtube_video_validator/youtube_video_validator.dart';
import 'package:http/http.dart' as http;
class ChannelPage extends StatefulWidget {

  @override
  _ChannelPageState createState() => _ChannelPageState();

}

class _ChannelPageState extends State<ChannelPage> {
  TextEditingController _linkController = TextEditingController();
  List<VideosModel> myVideos = <VideosModel>[];

  bool isValid = false;
  User user;

  @override
  void initState() {
    super.initState();
    getSavedUser();
  }

  // set up the AlertDialog
  _displayDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Video Link'),
            content:
              TextField(
                controller: _linkController,
                decoration: InputDecoration(hintText: "Enter your YouTube video link here"),
              ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cancel'),
                onPressed: () {
                  _linkController.clear();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('Add'),
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
    title: Text("Error!"),
    content: Text("The link entered is not valid."),
  );

  _checkValidity(){
    String url = _linkController.text.toString();
    isValid = YoutubeVideoValidator.validateUrl(url);
    if(isValid){
      _linkController.clear();
      Navigator.of(context).pop();
      Navigator.of(context).push(new MaterialPageRoute(builder: (context){
        return AddVideoPage(videoUrl: url, user: user,);
      }));
    }else{
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
      body: FutureBuilder(
        future: getMyVideos(),
        builder: (BuildContext context, AsyncSnapshot<List<VideosModel>> snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.isEmpty) {
              return Center(
                child: Text("No video added"),
              );
            }else{
              return ListView.builder(
                  cacheExtent: 9000,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  padding: new EdgeInsets.all(8.0),
                  itemBuilder: (_, int index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                          return ViewMyVideo(snapshot.data[index].link, snapshot.data[index].totalViews, snapshot.data[index].gotView, snapshot.data[index].duration, snapshot.data[index].durationWatched, user, index);
                        }));
                      },
                      child: Card(
                          shadowColor: Colors.black,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.black,
                          child: myVideos[index]),
                    );
                  });
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return Center(child: Text("An error has occurred!"));
          }
        }
      )
    );
  }

  Future<List<VideosModel>> getMyVideos() async {
    myVideos.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id;
    id = prefs.getString('id');
    String Url = "https://appvideopromo.000webhostapp.com/VideoApp/getMyVideos.php?id=${id}";
    http.Response response = await http.get(Url);
    List test = json.decode(response.body);
    for(int i = 0 ; i <test.length; i++){
      String extractedId = test[i]['link'];
      VideosModel model = VideosModel(test[i]['link'],int.parse(test[i]['totalViews']),int.parse(test[i]['gotViews']),int.parse(test[i]['duration']),int.parse(test[i]['durationWatched']),extractedId.substring( extractedId.indexOf('=')+1, extractedId.length));
      myVideos.add(model);
    }
    return myVideos;
  }


  getSavedUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id, name, email, referral;
    int balance;
    id = prefs.getString('id');
    name = prefs.getString('name');
    email = prefs.getString('email');
    referral = prefs.getString('referral');
    String url = "https://appvideopromo.000webhostapp.com/VideoApp/getBalance.php?id=$id";
    http.Response response = await http.get(url);
    var test = jsonDecode(response.body);
    balance = int.parse(test['balance']);
    User newuser = new User(id: id, name: name, email: email, balance: balance, referral: referral);
    setState(() {
      user = newuser;
    });
  }
}
