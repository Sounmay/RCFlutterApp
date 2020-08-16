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

class Menu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  Menu({this.item, this.price, this.searchIndex});
}

class Orders {
  List item;
  List qty;
  String name;
  String number;
  String address;
  int total;
  bool isConfirmed;

  Orders(
      {this.item, this.qty, this.name, this.number, this.address, this.total, this.isConfirmed});
}