import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  int FQty = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
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
              " Total Amount :",
              style: TextStyle(color: Colors.white, fontSize: 22),
              textAlign: TextAlign.center,
              ),
            )
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                            Icons.radio_button_checked,
                            color: Colors.green,
                          ),
                    ),
                    Text(
                    "Vada Sambhar",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    ],
            ),
            Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                      Icons.remove,
                      ),
                  onPressed: () {
                      setState(() {
                      if (FQty > 0) {
                            FQty -= 1;
                      }
                      });
                      },
                   ),
                    Text(
                      '$FQty',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      IconButton(
                            icon: Icon(
                            Icons.add,
                                ),
                            onPressed: () {
                              setState(() {
                              FQty += 1;
                              });
                              },
                      ),
                ],
              ),
        ],
      )
    ],
      ),
    );
  }
}
