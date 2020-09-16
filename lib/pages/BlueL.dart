import 'package:flutter/material.dart';


class BlueLounge extends StatefulWidget {
  @override
  _BlueLoungeState createState() => _BlueLoungeState();
}

class _BlueLoungeState extends State<BlueLounge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Blue Lounge'),
      ),
      body: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 200.0,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    image: DecorationImage(
                        image: new AssetImage("assets/12.jpg"),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ButtonTheme(
                    child: RaisedButton(
                        color: Colors.deepOrange,
                        onPressed: () {
                          Navigator.pushNamed(context, "/bookingcalendar");
                        },
                        child: Text('Book',
                            style: TextStyle(color: Colors.white, fontSize: 18))),
                  )),
            ],
          ),
    );
  }
}
