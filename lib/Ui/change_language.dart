import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_promoter/controllers/language_controller.dart';

// ignore: must_be_immutable
class ChangeLanguage extends StatelessWidget {
  LanguageController languageControler = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Language', style: new TextStyle(
            color: Colors.white,
        ),),
        backgroundColor: Color.fromRGBO(255, 119, 125, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Select one of the languages below to change Application's Language",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ignore: deprecated_member_use
                new RaisedButton(
                  onPressed: () {
                    languageControler.changeLanguage('en', 'US');
                    Get.snackbar('Language Changed',
                        'Your Language has been changed to English',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Color.fromRGBO(171, 63, 65, 1));
                  },
                  color: Color.fromRGBO(255, 119, 129, 1),
                  child: Text("English",
                    style: new TextStyle(
                      color: Colors.white,
                    ),),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    languageControler.changeLanguage('hi', 'IN');
                    Get.snackbar('Language Changed',
                        'Your Language has been changed to Hindi',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Color.fromRGBO(171, 63, 65, 1));
                  },
                  color: Color.fromRGBO(255, 119, 129, 1),
                  child: Text("Hindi",
                    style: new TextStyle(
                      color: Colors.white,
                    ),),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    languageControler.changeLanguage('hi', 'FR');
                    Get.snackbar('Language Changed',
                        'Your Language has been changed to French',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Color.fromRGBO(171, 63, 65, 1));
                  },
                  color: Color.fromRGBO(255, 119, 129, 1),
                  child: Text("French",
                    style: new TextStyle(
                    color: Colors.white,
                  ),),
                  ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    languageControler.changeLanguage('hi', 'UR');
                    Get.snackbar('Language Changed',
                        'Your Language has been changed to Urdu',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Color.fromRGBO(171, 63, 65, 1));
                  },
                  color: Color.fromRGBO(255, 119, 129, 1),
                  child: Text("Urdu",
                    style: new TextStyle(
                      color: Colors.white,),
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
