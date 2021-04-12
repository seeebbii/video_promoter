import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/controllers/userController.dart';

import 'HomePage.dart';
import 'LoginScreen.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
  bool loggedIn;
  User user;

  SplashScreen({Key key, this.loggedIn}) : super(key: key);
}

class _SplashScreenState extends State<SplashScreen> {
  // final userController = Get.put(UserController());
  // final watchVideoController = Get.put(WatchVideoController());
  final userController = Get.put(UserController());

  Future<bool> checkLoggedInUser() async {
    await Future.delayed(
      Duration(seconds: 3),
    );
    return widget.loggedIn;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedInUser().then((status) {
      if (status) {
        userController.getUser();
        userController.getMyVideos();
        navigateToHome();
      } else {
        navigateToLogin();
      }
    });
  }

  void navigateToHome() {
    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }

  void navigateToLogin() {
    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image(
                         image: AssetImage('assets/splash.png'),
                         width: 120,
                         height: 120,
                       ),
                       Padding(padding: EdgeInsets.only(top: 15)),
                       Text("Video Promotor", style: TextStyle(
                         fontSize: 15
                       ),
                       ),
                       Padding(padding: EdgeInsets.only(top: 5)),
                       Text("Developed By Code Miners", style: TextStyle(
                         fontSize: 12
                       ),
                       ),
                     ],
                    ),
                  ),
                ),
                Expanded(flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                      ],

                    ),)
              ],
            )
          ],
        ),
      );
  }
}
