import 'package:flutter/material.dart';

class ConsentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consent'),
        backgroundColor: Color.fromRGBO(255, 119, 129, 1),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "By using this Application you Agree to use your Youtube Channel videos on this Platform. ",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "You will be responsible for Any harm Caused to Your YouTube Channel or Viewership.",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Management of Video Promoter Mobile application and the Developers will not be Responsible for any Action taken against your YouTube account or Channel.",
                style: TextStyle(fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }
}
