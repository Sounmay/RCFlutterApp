import 'package:flutter/material.dart';
import 'package:rcapp/models/event.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('My booking'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Room : " + event.Lounge, style: Theme.of(context).textTheme.display1,),
            SizedBox(height: 20.0),
            Text("Booked by : " + event.name),
            SizedBox(height: 20.0),
            Text("Personal Number : " + event.personalno),

          ],
        ),
      ),
    );
  }
}