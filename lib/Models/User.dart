class User{
  String id;
  String name;
  String email;
  int balance;
  String referral;


  User(this.id, this.name, this.email, this.referral);



  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    email = json['email'];
    name = json['name'];
    referral = json['referral'];
  }
}

