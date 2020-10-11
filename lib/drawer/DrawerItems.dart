
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Ui/LoginScreen.dart';

class DrawerItems extends StatelessWidget {
  User user;

  DrawerItems({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              accountName: Text(user.name,
                  style: TextStyle(
                      color: Color(0xFFC11010),
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              accountEmail: Text(
                user.email,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              currentAccountPicture: CircleAvatar(
                child: Text(user.name[0].toUpperCase()),
              ),
            ),

            Divider(
              height: 15,
              thickness: 2,
              indent: 50,
              endIndent: 50,
            ),
            new ListTile(
              onTap: () {
                Navigator.of(context).pop();
                logOutHandler(context);
              },
              leading: Icon(
                Icons.exit_to_app,
                size: 20,
                color: Color(0xFFC11010),
              ),
              title: Text(
                'Log Out',
                style: TextStyle(color: Color(0xFFC11010)),
              ),
            )
          ],
        ),
      ),
    );
  }


  void logOutHandler(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);
    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }
}
