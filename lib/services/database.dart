import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference foodCollection = Firestore.instance.collection('foodCollection');

  Future updateUserData(String food, int price, int quantity) async {
    return await foodCollection.document(uid).setData({
      'food': food,
      'price': price,
      'quantity': quantity,
    });
  }

}