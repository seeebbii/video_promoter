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
      body: Column(
        children: [
          Text(
              "Select one of the languages below to change Application's Language"),
          Row(
            children: [
              RaisedButton(
                onPressed: () {
                  languageControler.changeLanguage('en', 'US');
                  Get.snackbar('Language Changed',
                      'Your Language has been changed to English');
                },
                child: Text("English"),
              ),
              ElevatedButton(
                onPressed: () {
                  languageControler.changeLanguage('hi', 'IN');
                  Get.snackbar('Language Changed',
                      'Your Language has been changed to Hindi');
                },
                child: Text("Hindi"),
              ),
              ElevatedButton(
                onPressed: () {
                  languageControler.changeLanguage('hi', 'FR');
                  Get.snackbar('Language Changed',
                      'Your Language has been changed to French');
                },
                child: Text("French"),
              ),
              ElevatedButton(
                onPressed: () {
                  languageControler.changeLanguage('hi', 'UR');
                  Get.snackbar('Language Changed',
                      'Your Language has been changed to Urdu');
                },
                child: Text("Urdu"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
