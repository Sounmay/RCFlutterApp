import 'package:flutter/material.dart';



class MilapLounge extends StatefulWidget {
  @override
  _MilapLoungeState createState() => _MilapLoungeState();
}

class _MilapLoungeState extends State<MilapLounge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Milap Lounge'),
      ),
      body: new ListView(
        children: <Widget>[
          InkWell(
            child: Container(
              height: 200.0,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  image: DecorationImage(
                      image: new AssetImage("assets/17.jpg"),
                      fit: BoxFit.fill)),
            ),
          ),
        ],
      ),
    );
  }
}
