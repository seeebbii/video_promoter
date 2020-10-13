import 'package:flutter/material.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AddVideoPage extends StatefulWidget {
  String videoUrl;
  User user;

  @override
  _AddVideoPageState createState() => _AddVideoPageState();

  AddVideoPage({Key key, this.videoUrl, this.user}) : super(key: key);
}

class _AddVideoPageState extends State<AddVideoPage> {
  YoutubePlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl),
        flags: YoutubePlayerFlags(autoPlay: true));
  }

  final List<int> viewsList = [35, 50, 100, 200, 300, 400, 500, 750, 1000];
  final List<int> secondsList = [
    45,
    60,
    90,
    120,
    150,
    180,
    240,
    300,
    360,
    420,
    480,
    540
  ];
  int selectedViewCount = 35;
  int selectedSeconds = 45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Video"),
        backgroundColor: Colors.red,
        actions: [
          Image.asset(
            'assets/logo/clock.png',
            width: 22,
            color: Colors.white,
          ),
          FlatButton(
            textColor: Colors.white,
            minWidth: 15,
            onPressed: () {},
            child: widget.user.balance == null
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      backgroundColor: Color(0xFFF1959B),
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.red.shade700),
                    ),
                  )
                : Text(
                    "${widget.user.balance}",
                    style: TextStyle(fontSize: 20.5),
                  ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(controller: controller),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Number of Views ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  DropdownButton(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    underline: Divider(height: 5, thickness: 3),
                    value: selectedViewCount,
                    onChanged: (value) {
                      setState(() {
                        selectedViewCount = value;
                      });
                    },
                    items: viewsList.map((value) {
                      return DropdownMenuItem(
                        child: Text("$value"),
                        value: value,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time Duration (Seconds) ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  DropdownButton(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    underline: Divider(height: 5, thickness: 3),
                    value: selectedSeconds,
                    onChanged: (value) {
                      setState(() {
                        selectedSeconds = value;
                      });
                    },
                    items: secondsList.map((value) {
                      return DropdownMenuItem(
                        child: Text("$value"),
                        value: value,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Cost",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "787",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: RaisedButton(
                elevation: 5,
                color: Colors.red,
                onPressed: (){

                },
                child: Text(
                  "DONE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
