import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;

  MenuCard({this.categoryName, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          width: 65,
          height: 65,
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('$imagePath'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(6)),
          child: null),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '$categoryName',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ]);
  }
}
