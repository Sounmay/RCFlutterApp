import 'package:flutter/material.dart';
import 'package:rcapp/models/user.dart';
import 'package:rcapp/pages/storeData.dart';

class FoodCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final int itemprice;

  FoodCard({this.categoryName, this.imagePath, this.itemprice});

  StoreData storeData = StoreData();

  void addToCart(String item, int price) {
    // String item = post.item;
    // int price = post.price;
  

    Map<String, int> qtyDetail = storeData.retrieveQtyDetails();

    int qty = 1;

    qtyDetail.forEach((key, value) {
      if (key == item) {
        qty = value;
      }
    });

    if (qty > 1) {
      storeData.StoreFoodDetails(item, price, qty);
    } else {
      storeData.StoreFoodDetails(item, price, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
        width: 160,
        margin: EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(6)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 60,
                        child: Text(
                        categoryName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                    ),
                    Text(
                      '₹' + '$itemprice',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    addToCart(categoryName, itemprice);
                  },
                  child: Container(
                    height: 25,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 0.1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Add',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ]),
        ));
  }
}
