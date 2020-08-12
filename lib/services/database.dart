import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcapp/models/category.dart';

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

//create menu object based on firebase
Future menu;

Future getPosts(numb) async {
  var firestore = Firestore.instance;
  QuerySnapshot qn =
      await firestore.collection('${menucategories[numb]}').getDocuments();
  return qn.documents;
}
