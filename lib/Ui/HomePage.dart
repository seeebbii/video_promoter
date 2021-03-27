import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Models/stateMachine.dart';
import 'package:video_promoter/Ui/ChannelPage.dart';
import 'package:video_promoter/Ui/OthersPage.dart';
import 'package:video_promoter/Ui/ViewPage.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:video_promoter/controllers/watchVideoController.dart';
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
  final userController = Get.put(UserController());
  final watchVideoController = Get.put(WatchVideoController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    watchVideoController.getVideo();
    currentScreen = ViewPage();
  }

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
      userController.currentTab.value = index;
    });

    if(index != 1 && watchVideoController.isPlayerReady.value){
      setState(() {
        watchVideoController.isStateChanged.value = true;
      });

      watchVideoController.youtubeController.value.pause();
    }else{
      setState(() {
        watchVideoController.isStateChanged.value = false;
      });

    }
    // else{
    //   watchVideoController.youtubeController.value.play();
    //   setState(() {
    //     watchVideoController.isStateChanged.value = false;
    //   });
    //
    // }
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
      drawer: userController.currentTab.value != 1 ? DrawerItems() : null,
      appBar: AppBar(
        title: Text("Video Promoter"),
        backgroundColor: Colors.red,
        actions: [
          Image.asset(
            'assets/logo/clock.png',
            width: 22,
            color: Colors.white,
          ),
          GetX<UserController>(
            init: UserController(),
            builder: (controller) {
              return FlatButton(
                textColor: Colors.white,
                minWidth: 15,
                onPressed: () {
                  setState(() {
                    userController.currentTab.value = 2;
                  });
                },
                child: controller.user.balance == null
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
                    : Obx(() => Text(
                  "${userController.userBal.value}",
                  style: TextStyle(

                    fontSize: 20.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),),
                shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
              );
            }
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: IndexedStack(
          children: widgetList,
          index: userController.currentTab.value,
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
        currentIndex: userController.currentTab.value,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    userController.userVideos.clear();
    userController.currentTab.value = 1;
    watchVideoController.dispose();
    super.dispose();
  }

}
