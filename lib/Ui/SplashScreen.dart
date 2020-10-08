import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void checkLoggedInUser() async {
    await Future.delayed(Duration(seconds: 3),
    navigateToLogin);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedInUser();
  }

  void navigateToHome(){
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context){
      return HomePage();
    }));
  }
  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
    );
  }
}
