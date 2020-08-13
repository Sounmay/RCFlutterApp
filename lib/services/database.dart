import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcapp/models/category.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference foodCollection =
  Firestore.instance.collection('food');

  final CollectionReference userInfo =
  Firestore.instance.collection('userInfo');

  Future updateUserInfo(String name, bool isAdmin, String number) async {
    return await userInfo.document(uid).setData({
      'name': name,
      'isAdmin': isAdmin,
      'number': number,
    });
  }

  Future updateUserData(String food, int price, int quantity) async {
    return await foodCollection.document(uid).setData({
      'food': food,
      'price': price,
      'quantity': quantity,
    });
  }


}

// create menu object based on firebase
Future menu;

Future getPosts(numb) async {
  var firestore = Firestore.instance;
  QuerySnapshot qn =
  await firestore.collection('${menucategories[numb]}').getDocuments();
  return qn.documents;
}