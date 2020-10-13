import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Ui/AddVideoPage.dart';
import 'package:youtube_video_validator/youtube_video_validator.dart';
import 'package:http/http.dart' as http;
class ChannelPage extends StatefulWidget {
  @override
  _ChannelPageState createState() => _ChannelPageState();

}

class _ChannelPageState extends State<ChannelPage> {
  TextEditingController _linkController = TextEditingController();
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
      body: Center(
        child: Text('Channel'),
      ),
    );
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
