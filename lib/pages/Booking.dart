import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
        height: 200.0,
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('assets/12.jpg'),
            AssetImage('assets/13.jpg'),
            AssetImage('assets/3.jpg'),
            AssetImage('assets/4.jpg'),
            AssetImage('assets/5.jpg'),
          ],
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
        ));

    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Booking'),
      ),
      body: new ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          image_carousel,
        ],
      ),
    );
  }
}
