import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ShareScreen extends StatefulWidget {
  String referralId;
  ShareScreen({Key key, this.referralId}) : super(key:  key);

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  copyToClipbord(widget.referralId);
                },
                child: Container(
                  child: Text(
                      "${widget.referralId}"
                  ),
                ),
              ),
            ),
             RaisedButton(
               child: Text("Refer Now", style: TextStyle(color: Colors.white, fontSize: 15),),
               color: Colors.red,
               onPressed: (){
                 share(widget.referralId);
               },
             )
          ],
        )
      ),
    );
  }
}

Future<void> share(String referral) async{
  await FlutterShare.share(title: "Referral id",
  text: referral,
  chooserTitle: "Where you want to share?");
}

copyToClipbord(String referral){
  ClipboardManager.copyToClipBoard(referral).then((result) {
    Fluttertoast.showToast(
        msg: "Copied to clipboard.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  });
}
