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

  final CollectionReference confirmedOrders =
  Firestore.instance.collection('confirmedOrders');

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

  Future confirmOrderofUser(String id, String name, String number, List item, List qty, int total, bool isConfirmed) async {
    return await confirmedOrders
        .document(uid)
        .setData(
        {
          'id': id,
          'name': name,
          'number': number,
          'item': item,
          'quantity': qty,
          'total': total,
          'isConfirmed': isConfirmed
        }
    );
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