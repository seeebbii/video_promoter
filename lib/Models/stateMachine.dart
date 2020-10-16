import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class StateMachine{
  String _Data;

  static StateMachine _instance;
  static StateMachine get instance  {
    StateMachine();
    return _instance;
  }

  StateMachine(){
    if(_instance == null)
      _instance =  new StateMachine();
  }

  set Data(String value) {
    if(_Data.length>0)
      _Data += "," + value;
    else
      _Data = value;
  }
  String get Data => _Data;

  void preserve() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('vidData', Data);
  }

  void load() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Data = prefs.getString('vidData');
  }
}