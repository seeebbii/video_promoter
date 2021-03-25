class User{
  String id;
  String name;
  String email;
  int balance;
  String referral;
  String videoWatched;


  User({this.id, this.name, this.email, this.balance , this.referral, this.videoWatched});

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    email = json['email'];
    name = json['name'];
    referral = json['referral'];
    videoWatched = json['vid_watched'];
  }
}

