import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_promoter/controllers/language_controller.dart';

class ChangeLanguage extends StatelessWidget {
  LanguageController languageControler = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Language'),
        backgroundColor: Colors.red[400],
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
                ElevatedButton(
                  onPressed: () {
                    languageControler.changeLanguage('en', 'US');
                    Get.snackbar('Language Changed',
                        'Your Language has been changed to English',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.lightGreen);
                  },
                  child: Text("English"),
                ),
                ElevatedButton(
                  onPressed: () {
                    languageControler.changeLanguage('hi', 'IN');
                    Get.snackbar('Language Changed',
                        'Your Language has been changed to Hindi',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.lightGreen);
                  },
                  child: Text("Hindi"),
                ),
                ElevatedButton(
                  onPressed: () {
                    languageControler.changeLanguage('hi', 'FR');
                    Get.snackbar('Language Changed',
                        'Your Language has been changed to French',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.lightGreen);
                  },
                  child: Text("French"),
                ),
                ElevatedButton(
                  onPressed: () {
                    languageControler.changeLanguage('hi', 'UR');
                    Get.snackbar('Language Changed',
                        'Your Language has been changed to Urdu',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.lightGreen);
                  },
                  child: Text("Urdu"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
