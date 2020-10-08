import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_promoter/Ui/SignupScreen.dart';
import 'package:video_promoter/utilities/constant_dart.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailKey = GlobalKey<FormState>();
  final _passKey  = GlobalKey<FormState>();
  String email, pass;
  bool progress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    databaseReference = database.reference().child('FrenzyUsers');
  }

  void validate() async{
    setState(() {
      progress = true;
    });
    if(_emailKey.currentState.validate() && _passKey.currentState.validate()){
      print('Validate');
    }
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
          child: Form(
            key: _emailKey,
            child: TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return '*';
                }else{
                  email = value.trim();
                  return null;
                }
              },
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
          child: Form(
            key: _passKey,
            child: TextFormField(
              validator: (value){
                if(value.isNotEmpty){
                  pass = value;
                  return null;
                }else{
                  return '*';
                }
              },
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
        onPressed: validate,
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
}
