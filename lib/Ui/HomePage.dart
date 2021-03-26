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

  final userController = Get.find<UserController>();
  final watchVideoController = Get.find<WatchVideoController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    watchVideoController.getVideo();
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

    if (index != 1 && watchVideoController.isPlayerReady.value) {
      watchVideoController.isStateChanged.value = true;
      watchVideoController.youtubeController.value.pause();
    } else {
      watchVideoController.youtubeController.value.play();
      watchVideoController.isStateChanged.value = false;
    }

    // if(index != 1) {
    //   if (StateMachine.Viewinstance != null) {
    //     StateMachine.Viewinstance.controller.pause();
    //   }
    // }
    // else {
    //   if (StateMachine.Viewinstance != null) {
    //     StateMachine.Viewinstance.controller.play();
    //   }
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
      drawer: DrawerItems(),
      appBar: AppBar(
        title: Text("Video Promoter".tr),
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
                  onPressed: () {},
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
                      : Text(
                          "${controller.userBal}",
                          style: TextStyle(
                            fontSize: 20.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                );
              }),
        ],
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: IndexedStack(
          children: widgetList,
          index: currentTab,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Promote".tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: "View".tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later_outlined),
            label: "Minutes".tr,
          ),
        ],
        currentIndex: currentTab,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
