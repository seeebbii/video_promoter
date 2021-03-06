import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                child: Text("Available offers", style: TextStyle(
                  fontSize: 15
                ),),
              ),
              returnCard(500.00, 1000, "Minutes"),
              returnCard(950.00, 2000, "Minutes"),
              returnCard(1800.00, 4000,  "Minutes"),
              returnCard(2400.00, 1000,  "Hours"),
              returnCard(4200.00, 2000,  "Hours"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 50,
                  child: Text("To avail any of these offers please contact +92 03362046672", style: TextStyle(
                      fontSize: 15
                  ),
                  textAlign: TextAlign.center,),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget returnCard(double ammount, int values, String type){
    return Card(
      child: ListTile(
        title: Text(
            "Get ${values} ${type}"
        ),
        subtitle: Text(
            "${values} ${type.toLowerCase()} will be added to your account"
        ),
        trailing: Text(
            "Rs ${ammount}"
        ),
      ),
    );
  }

}
