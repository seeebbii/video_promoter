import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OthersPage extends StatefulWidget {
  @override
  _OthersPageState createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 50,
              child: Text(
                "Available offers".tr,
                style: TextStyle(fontSize: 15),
              ),
            ),
            returnCard(500.00, 1000, "Minutes"),
            SizedBox(
              height: 10,
            ),
            returnCard(950.00, 2000, "Minutes"),
            SizedBox(
              height: 10,
            ),
            returnCard(1800.00, 4000, "Minutes"),
            SizedBox(
              height: 10,
            ),
            returnCard(24000.00, 1000, "Hours"),
            SizedBox(
              height: 10,
            ),
            returnCard(42000.00, 2000, "Hours"),
            SizedBox(
              height: 10,
            ),
            returnCard(60000.00, 4000, "Hours"),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 50,
                child: Text(
                  'To avail any of these offers please contact +923350215159'
                      .tr,
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget returnCard(double ammount, int values, String type) {
    return Card(
      child: ListTile(
        title: Text("Get $values $type"),
        subtitle: Text(
            "$values ${type.toLowerCase()} will be added to your account"),
        trailing: Text("Rs $ammount"),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
