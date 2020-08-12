import 'package:flutter/material.dart';
import 'package:rcapp/pages/order_card.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Cart'),
      ),
      body: Container(
        child: new ListView(
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(height: 30),
            OrderCard(),
          ],
        ),
      ),
    );
  }
}
