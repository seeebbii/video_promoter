import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:video_promoter/controllers/watchVideoController.dart';

import 'HomePage.dart';
import 'LoginScreen.dart';

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
      backgroundColor: Colors.red,
      body: Center(
        child: Image(
          image: AssetImage('assets/splash.png'),
        ),
      ),
    );
  }
}
