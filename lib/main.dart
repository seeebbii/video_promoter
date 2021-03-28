import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Ui/SplashScreen.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:wakelock/wakelock.dart';


import 'Models/messages.dart';

bool loggedIn;
SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Wakelock.enable();
  var param1;
  var param2;
  prefs = await SharedPreferences.getInstance();
  if (prefs.getString("param1") == null) {
    param1 = 'en';
    param2 = 'US';
  } else {
    param1 = prefs.getString('param1');
    param2 = prefs.getString('param2');
  }

  return runApp(new GetMaterialApp(
    translations: Messages(),
    locale: Locale(param1, param2),
    debugShowCheckedModeBanner: false,
    title: "Video Promotion".tr,
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
