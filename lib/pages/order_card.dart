import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Card(
            child: Container(
              height: 90.0,
              width: 100.0,
              margin: new EdgeInsets.only(left: 20.0, right:20.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: new Center(
                child: new Text(
                  "Total Amount:",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                )
              )
            ),
          ),
      );
  }
}
