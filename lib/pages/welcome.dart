import 'package:flutter/material.dart';


class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/wrapper');
    });
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: new ListView(
        children: [
          Image(image: AssetImage('assets/rclogo.png')),
          Center(
              child:Text(
              'ROURKELA CLUB',
              style: TextStyle(
                color: Colors.white,
                fontSize: 45.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}