import 'package:rcapp/pages/Food.dart';

class FoodList{
  final String id;
  final String Name;
  final double price;

  FoodList({this.id, this.Name, this.price});
}

final foodlist = [
  FoodList(
    id: "1",
    Name: "Vada Sambhar",
    price: 30,
  ),
  FoodList(
    id: "2",
    Name: "Idli Sambhar",
    price: 20,
  ),
];