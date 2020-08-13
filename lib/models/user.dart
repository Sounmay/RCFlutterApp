class User {
  final String uid;

  User({this.uid});
}

class UserData {
  String uid;
  String name;
  String number;
  bool isAdmin;

  setvalues(String uid, String name, String number, bool isAdmin) {
    this.uid = uid;
    this.name = name;
    this.number = number;
    this.isAdmin = isAdmin;
  }
}

UserData currentUser;