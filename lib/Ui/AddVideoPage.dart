import 'package:flutter/material.dart';
import 'package:video_promoter/Models/User.dart';
import 'package:video_promoter/Ui/HomePage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

class AddVideoPage extends StatefulWidget {
  String videoUrl;
  User user;

  @override
  _AddVideoPageState createState() => _AddVideoPageState();

  AddVideoPage({Key key, this.videoUrl, this.user}) : super(key: key);
}

class _AddVideoPageState extends State<AddVideoPage> {
  YoutubePlayerController controller;
  TextEditingController viewsController;
  TextEditingController minController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl),
        flags: YoutubePlayerFlags(autoPlay: true));
  }


  int selectedViewCount = 0;
  int selectedMinCount = 0;

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
                    style:
                        TextStyle(fontSize: 20.5, fontWeight: FontWeight.w400),
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
                  Container(
                      width: 80.0,
                      height: 50,
                      child: TextField(
                        onChanged: (String value){
                          setState(() {
                            selectedViewCount = int.parse(value);
                          });
                          print(selectedViewCount);
                        },
                        controller: viewsController,
                        keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Views Count"
                        ),
                          style: TextStyle(
                              fontSize: 12,
                              height: 2.0,
                              color: Colors.black,
                          )
                      )
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time Duration (Min) ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                      width: 80.0,
                      height: 50,
                      child: TextField(
                        onChanged: (String value){
                          setState(() {
                            selectedMinCount = int.parse(value);
                          });
                          print(selectedMinCount);
                        },
                        controller: minController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Min Count"
                          ),
                          style: TextStyle(
                            fontSize: 12,
                            height: 2.0,
                            color: Colors.black,
                          )
                      )
                  )
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
                    "${selectedViewCount * selectedMinCount}",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
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
                onPressed: () {
                  validate();
                },
                child: Text(
                  "DONE",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'NOTE: YouTube needs 72 hours to update views from third party apps. So please wait at least 72 hours before checking.'),
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog invalid = AlertDialog(
    title: Text("Insufficient fund!"),
    content: Text("Watch more videos to earn."),
  );

  AlertDialog invalidCount = AlertDialog(
    title: Text("View count or Min count cannot be 0"),
    content: Text("Values should be greater than 0"),
  );

  void validate() async {
    int totalCost = selectedViewCount * selectedMinCount;
    if (widget.user.balance >= totalCost) {

      if(selectedMinCount > 0 && selectedViewCount > 0){
        String URL =
            'https://appvideopromo.000webhostapp.com/VideoApp/addVideo.php?email=${widget.user.email}&name=${widget.user.name}&id=${widget.user.id}&link=${widget.videoUrl}&totalViews=${selectedViewCount}&gotViews=0&duration=${selectedMinCount}&durationWatched=0';
        http.Response response = await http.get(URL);
        if (response.body == "Video added successfully") {
          // Deduct balance from the server
          String URL =
              'https://appvideopromo.000webhostapp.com/VideoApp/updateBalance.php?id=${widget.user.id}&cost=${totalCost}';
          http.Response response = await http.get(URL);
          print(response.body);
          Navigator.of(context).pop();
          Navigator.of(context)
              .pushReplacement(new MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        }
      }else{
        // COUNT < 0
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return invalidCount;
          },
        );
      }
    } else {
      // Not sufficient stuff
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return invalid;
        },
      );
    }
  }
}
