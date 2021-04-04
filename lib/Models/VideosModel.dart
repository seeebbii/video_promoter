
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class VideosModel extends StatefulWidget {
  String link;
  int totalViews;
  int gotView;
  int duration;
  int durationWatched;
  String extractedId;
  int vidId;


  VideosModel(this.link, this.totalViews, this.gotView, this.duration,
      this.durationWatched, this.extractedId, this.vidId);

  @override
  _VideosModelState createState() => _VideosModelState();
}

class _VideosModelState extends State<VideosModel> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: 'https://img.youtube.com/vi/${widget.extractedId}/hqdefault.jpg', height: 350,
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
