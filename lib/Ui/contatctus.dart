import 'package:flutter/material.dart';

// ignore: camel_case_types
class contactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us", style: new TextStyle(
          color: Colors.white,
        ),),
        backgroundColor:Color.fromRGBO(255, 119, 129, 1),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Any queries related to anything please let us know.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Our Contact Details are given Below",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Email : Sameer6059@gmail.com",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "WhatsApp : 00923350215159",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
