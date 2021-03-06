import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Models/stateMachine.dart';
import 'package:video_promoter/Ui/ChannelPage.dart';
import 'package:video_promoter/Ui/OthersPage.dart';
import 'package:video_promoter/Ui/ViewPage.dart';
import 'package:video_promoter/drawer/DrawerItems.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  User user;


  @override
  _HomePageState createState() => _HomePageState();

  // HomePage({Key key, this.user}) : super(key: key);
}

class _HomePageState extends State<HomePage> {
  Widget currentScreen;
  int balance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSavedUser();
    getBalance();
    currentScreen = ViewPage();
    currentTab = 1;
  }

  int currentTab;
  final PageStorageBucket bucket = PageStorageBucket();
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Press again to exit', backgroundColor: Colors.black);
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _onItemTapped(int index) {
    setState(() {
      currentTab = index;

    });

    if(index != 1) {
      if (StateMachine.Viewinstance != null) {
        StateMachine.Viewinstance.controller.pause();
      }
    }
    else {
      if (StateMachine.Viewinstance != null) {
        StateMachine.Viewinstance.controller.play();
      }
    }
  }

  static List<Widget> widgetList = <Widget>[
    ChannelPage(),
    ViewPage(),
    OthersPage()
  ];


  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.red.withOpacity(0.7));
    return Scaffold(
      drawer: DrawerItems(
        user: widget.user,
      ),
      appBar: AppBar(
        title: Text("Video Promoter"),
        backgroundColor: Colors.red,
        actions: [
          Image.asset('assets/logo/clock.png',  width: 22, color: Colors.white,),
          FlatButton(
            textColor: Colors.white,
            minWidth: 15,
            onPressed: (){

            },
            child: balance==null? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                backgroundColor: Color(0xFFF1959B),
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red.shade700),
              ),
            ): Text("$balance", style: TextStyle(
                fontSize: 20.5,
              fontWeight: FontWeight.w400,
            ),),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: IndexedStack(
          children:widgetList,
          index:currentTab,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Promote',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later_outlined),
            label: 'Minutes',
          ),
        ],
        currentIndex: currentTab,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }

  getBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id;
    id = prefs.getString('id');
    String url = "https://appvideopromo.000webhostapp.com/VideoApp/getBalance.php?id=$id";
    http.Response response = await http.get(url);
    var test = jsonDecode(response.body);
    setState(() {
      balance = int.parse(test['balance']);
    });
  }
  getSavedUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id, name, email, referral;
    id = prefs.getString('id');
    name = prefs.getString('name');
    email = prefs.getString('email');
    referral = prefs.getString('referral');
    User user = new User(id: id, name: name, email: email, balance: 0, referral: referral);
    setState(() {
      widget.user = user;
    });
  }

}
