import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_promoter/Ui/LoginScreen.dart';
import 'package:video_promoter/Ui/change_language.dart';
import 'package:video_promoter/Ui/consentPage.dart';
import 'package:video_promoter/Ui/contatctus.dart';
import 'package:video_promoter/Ui/privacypolicy.dart';
import 'package:video_promoter/Ui/withdrawalPage.dart';
import 'package:video_promoter/controllers/userController.dart';
import 'package:video_promoter/controllers/watchVideoController.dart';
import 'package:video_promoter/drawer/ShareScreen.dart';

class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final watchVideoController = Get.find<WatchVideoController>();
    final userController = Get.find<UserController>();

    if (watchVideoController.isPlayerReady.value) {
      watchVideoController.youtubeController.value.pause();
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromRGBO(255, 119, 129, 1)),
              accountName: Text(
                  userController.user.name == null
                      ? "Loading..."
                      : userController.user.name,
                  style: TextStyle(
                      color: Color.fromRGBO(171, 63, 65, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              accountEmail: Text(
                userController.user.email == null
                    ? "Loading..."
                    : userController.user.email,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  userController.user.name == null
                      ? " "
                      : userController.user.name[0].toUpperCase(),
                  style: TextStyle(color: Color.fromRGBO(255, 119, 129, 1)),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => ShareScreen(
                      referralId: userController.user.referral,
                    ));
              },
              leading: Icon(
                Icons.share,
                size: 20,
              ),
              title: Text(
                'Share with Friends'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                const url =
                    'https://play.google.com/store/apps/developer?id=MUHAMMAD+ISHAQ';
                launchURL(url);
              },
              leading: Icon(
                Icons.share,
                size: 20,
              ),
              title: Text(
                'Our Other Apps'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => ConsentPage());
              },
              leading: Icon(
                Icons.assignment_rounded,
                size: 20,
              ),
              title: Text(
                'Consent'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => PrivacyPolicy());
              },
              leading: Icon(
                Icons.policy,
                size: 20,
              ),
              title: Text(
                'Privacy policy'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => ChangeLanguage());
              },
              leading: Icon(
                Icons.language,
                size: 20,
              ),
              title: Text(
                'Change Language'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => WithdrawalPage());
              },
              leading: Icon(
                Icons.money,
                size: 20,
              ),
              title: Text(
                'Withdrawal'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => contactUs());
              },
              leading: Icon(
                Icons.attach_email,
                size: 20,
              ),
              title: Text(
                'Contact us'.tr,
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
                color: Color.fromRGBO(171, 63, 65, 1.0),
              ),
              title: Text(
                'Log Out'.tr,
                style: TextStyle(color: Color.fromRGBO(171, 63, 65, 1.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void logOutHandler(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    prefs.setBool('loggedIn', false);

    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (_) {
      return LoginScreen();
    }), (route) => false);
  }
}
