import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:rcapp/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
        height: 200.0,
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('assets/1.jpg'),
            AssetImage('assets/2.jpg'),
            AssetImage('assets/3.jpg'),
            AssetImage('assets/4.jpg'),
            AssetImage('assets/5.jpg'),
          ],
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
        ));

    Widget image_carousel2 = new Container(
        height: 150.0,
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('assets/6.jpg'),
            AssetImage('assets/7.jpg'),
            AssetImage('assets/8.jpg'),
          ],
          autoplay: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
        ));

    Widget image_carousel3 = new Container(
        height: 150.0,
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('assets/1.jpg'),
            AssetImage('assets/2.jpg'),
            AssetImage('assets/3.jpg'),
          ],
          autoplay: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
        ));

    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Home'),
      ),
      body: new ListView(
        children: <Widget>[
          // _children[_currentIndex],
          image_carousel,
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "  Today's Menu",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              OutlineButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.grey,
                  child: Text('View')),
            ],
          ),
          SizedBox(height: 7.0),
          image_carousel2,
          SizedBox(height: 20.0),
          Text(
            "  Upcoming Events",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 10.0),
          image_carousel3,
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _auth.signOut();
          },
          child: Text('Sign Out')),
    );
  }
}
