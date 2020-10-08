import 'package:flutter/material.dart';
import 'package:video_promoter/Ui/SplashScreen.dart';

void main(){
  return runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "VideoPromotion",
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
