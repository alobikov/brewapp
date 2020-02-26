class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;
  final String token;

  UserData({this.uid, this.name, this.sugars, this.strength, this.token});
}