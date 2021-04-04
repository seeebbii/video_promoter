import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Ui/ViewPage.dart';
class StateMachine{
  // ignore: non_constant_identifier_names
  String _Data;

  static StateMachine _instance;
  static StateMachine get instance  {
    StateMachine();
    return _instance;
  }

  // ignore: non_constant_identifier_names
  static ViewPage Viewinstance;

  StateMachine(){
    if(_instance == null)
      _instance =  new StateMachine();
  }

  // ignore: non_constant_identifier_names
  set Data(String value) {
    if(_Data.length>0)
      _Data += "," + value;
    else
      _Data = value;
  }
  // ignore: non_constant_identifier_names
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