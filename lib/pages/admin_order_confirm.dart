import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AdminOrder extends StatefulWidget {
  @override
  _AdminOrderState createState() => _AdminOrderState();
}

class _AdminOrderState extends State<AdminOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Orders'),
              ])
      ),
      body: new ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Container(
            alignment: Alignment.topLeft,
            height: 220.0,
            width: 90.0,
            margin: new EdgeInsets.only(left: 20.0, right:20.0),
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child:  Text(
                      "Order Number : " + "111",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child:Text(
                        "Aug 4th 2020"
                    ),
                  ),
                ],
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  Text(
                        "Name : " + "Aswin Kumar Raju",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  Text(
                        "Personal No. : " + "999999",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  Text(
                        "Cost : ₹" + "5555",
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/orderdetails');
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        child: Text('View'),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: FlatButton(
                        onPressed: () {},
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        child: Text('Confirm'),
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
            ],
            ),
          ),
        ],
      ),
    );
  }
}
