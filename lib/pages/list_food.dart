import 'package:rcapp/pages/Food.dart';

class FoodItem {
  final String title;
  final int price;
  FoodItem({
    this.title,
    this.price,
});
}

List<FoodItem> loadFoodItem(){
  var fi = <FoodItem>[
    FoodItem(
      title: "Vada Sambar",
      price: 30,
    )
  ];
}