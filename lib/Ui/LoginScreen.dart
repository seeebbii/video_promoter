import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Ui/HomePage.dart';
import 'package:video_promoter/Ui/SignupScreen.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:video_promoter/controllers/watchVideoController.dart';
import 'package:video_promoter/utilities/constant_dart.dart';
import 'package:http/http.dart' as http;
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var _emailFieldController = new TextEditingController();
  var _passFieldController = new TextEditingController();
  final userController = Get.put(UserController());
  final watchVideoController = Get.find<WatchVideoController>();
  bool progress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  Widget _emailFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          height: 60.0,
          decoration: kBoxDecorationStyle,
          alignment: Alignment.center,
          child: TextField(
            controller: _emailFieldController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: "Enter your Email",
                hintStyle: kHintTextStyle
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordFormField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 60.0,
          decoration: kBoxDecorationStyle,
          alignment: Alignment.center,
          child: TextField(
            controller: _passFieldController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: "Enter your Password",
                hintStyle: kHintTextStyle
            ),
          ),
        ),
      ],
    );
  }

  Widget _forgotPass() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child:Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }


  Widget _buildLoginBtn() {
    return !progress?Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
          loginUser();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.red,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    ):CircularProgressIndicator(
      strokeWidth: 1.5,
      backgroundColor: Color(0xFFF1959B),
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red.shade700),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
          return SignupScreen();
        }));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFF1959B),
                        Color(0xFFF07470),
                        Color(0xFFEA4C46),
                        Color(0xFFDC1C13),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Text(
                    'Video Promoter',
                    style: TextStyle(
                        letterSpacing: 2.5,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.2
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        _emailFormField(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _passwordFormField(),
                        _forgotPass(),
                        _buildLoginBtn(),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    // Validating text fields
    setState(() {
      progress = true;
    });
    if (_emailFieldController.text
        .toString()
        .isNotEmpty && _passFieldController.text
        .toString()
        .isNotEmpty) {
      String email, pass;
      email = _emailFieldController.text.trim();
      pass = _passFieldController.text.trim();

      // Creating a json encoded data to send the data to server
      String jsonObj = jsonEncode(<String, dynamic>{
        'user_email': email,
        'user_password': pass,
      });

      String URL = 'https://www.videopromoter.tk/Video_app/login.php';
      http.Response response = await http.post(
        URL,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonObj,
      );
      // Checking if the user has successfully logged in
      if (response.statusCode == 200) {
        watchVideoController.getVideo();
        setState(() {
          progress = false;
        });
        Fluttertoast.showToast(
            msg: "Login successful.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        saveObjectToPreferences(User.fromJson(json.decode(response.body)));
        userController.getUser();
        userController.getMyVideos();
        await Future.delayed(Duration(seconds: 2), () {
          // Switch to home page here
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
        });
      } else if (response.statusCode == 401) {
        setState(() {
          progress = false;
        });
        Fluttertoast.showToast(
            msg: "Invalid email or password!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        setState(() {
          progress = false;
        });
        Fluttertoast.showToast(
            msg: "An error has occurred!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      setState(() {
        progress = false;
      });
      Fluttertoast.showToast(
          msg: "Text fields must not be empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  void saveObjectToPreferences(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.id);
    prefs.setBool('loggedIn', true);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('referral', user.referral);
  }
}
