import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Ui/SplashScreen.dart';

bool loggedIn;
SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  return runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Video Promotion",
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (prefs.getBool('loggedIn') == null) {
        loggedIn = false;
      } else {
        loggedIn = prefs.getBool('loggedIn');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      loggedIn: loggedIn,
    );
  }
}
