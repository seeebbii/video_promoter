import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Ui/LoginScreen.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:video_promoter/controllers/watchVideoController.dart';
import 'package:video_promoter/drawer/ShareScreen.dart';

class DrawerItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final watchVideoController = Get.find<WatchVideoController>();
    final userController = Get.find<UserController>();

    if( watchVideoController.isPlayerReady.value){
      watchVideoController.youtubeController.value.pause();
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              accountName: Text(userController.user.name == null ? "Loading..." : userController.user.name,
                  style: TextStyle(
                      color: Colors.red.shade900,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              accountEmail: Text(
                    userController.user.email == null ? "Loading..." : userController.user.email ,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  userController.user.name == null ? " " : userController.user.name[0].toUpperCase(),
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ShareScreen(
                    referralId: userController.user.referral,
                  );
                }));
              },
              leading: Icon(
                Icons.share,
                size: 20,
              ),
              title: Text(
                'Share with friends',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: Icon(
                Icons.assignment_rounded,
                size: 20,
              ),
              title: Text(
                'Consent',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: Icon(
                Icons.policy,
                size: 20,
              ),
              title: Text(
                'Privacy policy',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: Icon(
                Icons.attach_email,
                size: 20,
              ),
              title: Text(
                'Contact us',
                style: TextStyle(color: Colors.black),
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
                userController.dispose();
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
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: Icon(
                Icons.delete_forever,
                size: 20,
                color: Color(0xFFC11010),
              ),
              title: Text(
                'Delete account',
                style: TextStyle(color: Color(0xFFC11010)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logOutHandler(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    prefs.setBool('loggedIn', false);

    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }
}
