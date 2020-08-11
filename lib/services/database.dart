import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference foodCollection =
      Firestore.instance.collection('food');

  Future updateUserData(String food, int price, int quantity) async {
    return await foodCollection.document(uid).setData({
      'food': food,
      'price': price,
      'quantity': quantity,
    });
  }

  //get food stream
  // Stream<QuerySnapshot> get food {
  //   return foodCollection.snapshots()
  // }

}
