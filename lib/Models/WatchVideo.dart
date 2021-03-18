class WatchVideo{
  String link;
  int videoId;
  String email;
  String name;
  int uploaderId;
  int duration;

  WatchVideo({this.link, this.videoId, this.email, this.name, this.uploaderId, this.duration});

  WatchVideo.link(String link){
    this.link = link;
  }
}