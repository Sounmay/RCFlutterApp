import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcapp/models/category.dart';
import 'package:rcapp/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference foodCollection =
  Firestore.instance.collection('food');

  final CollectionReference chinesefoods =
  Firestore.instance.collection('chinese');

  final CollectionReference userInfo =
  Firestore.instance.collection('userInfo');

  final CollectionReference confirmedOrders =
  Firestore.instance.collection('confirmedOrders');

  Future updateUserInfo(String name, bool isAdmin, String number) async {
    return await userInfo.document(uid).setData({
      'name': name,
      'isAdmin': isAdmin,
      'number': number,
      'address': '',
    });
  }

  Future updateUserData(String food, int price, int quantity) async {
    return await foodCollection.document(uid).setData({
      'food': food,
      'price': price,
      'quantity': quantity,
    });
  }

  Future updateAddressData(String id, String address) async {
    return await userInfo.document(id).updateData({'address': address});
  }

  Future confirmOrderofUser(String id, String name, String number,
      String address, List item, List qty, int total, bool isConfirmed) async {
    return await confirmedOrders.document(number).setData({
      'id': id,
      'name': name,
      'number': number,
      'address': address,
      'item': item,
      'quantity': qty,
      'total': total,
      'isConfirmed': isConfirmed
    });
  }

  Future getPosts(numb) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('chinese').getDocuments();
    return qn.documents;
  }

  List<Menu> _menuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Menu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<Orders> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Orders(
          item: doc.data["item"] ?? [],
          qty: doc.data["quantity"] ?? [],
          name: doc.data["name"] ?? '',
          number: doc.data["number"] ?? '',
          address: doc.data["address"] ?? '',
          total: doc.data["total"]?? 0,
          isConfirmed: doc.data["isConfirmed"]?? false);
    }).toList();
  }

  Stream<List<Menu>> get chinese {
    return chinesefoods.snapshots().map(_menuListFromSnapshot);
  }

  final CollectionReference menuorders =
  Firestore.instance.collection("confirmedOrders");

  Stream<List<Orders>> get orders {
    return menuorders.snapshots().map(_orderListFromSnapshot);
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