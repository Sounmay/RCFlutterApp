import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final int itemprice;

  FoodCard({this.categoryName, this.imagePath, this.itemprice});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 160,
        margin: EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$imagePath'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              categoryName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white,),
            ),
            Text(
              '₹' + '$itemprice',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white),
            )
          ],
        )
        // child: Stack(
        //   children: <Widget>[

        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        // children: <Widget>[
        //   Text(
        //     categoryName,
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        //   ),
        //   Text(
        //     '₹' + '$itemprice',
        //   )
        // ],
        //     ),
        //   ],
        );
  }
}
