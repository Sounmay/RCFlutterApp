import 'package:firebase_auth/firebase_auth.dart';
import 'package:rcapp/models/event.dart';
import 'package:flutter/material.dart';
import 'package:rcapp/res/event_firestore_service.dart';
import 'package:rcapp/services/database.dart';

class AddEventPage extends StatefulWidget {
  final EventModel note;

  const AddEventPage({Key key, this.note}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _booking = DatabaseService();

  String _name = '';
  String _personalno = '';
  int slot = 1;
  DateTime _eventDate;
  int _value1 = 1;
  int _value2 = 1;

  var id;
  bool processing;

  List<String> loungeColor = ['Yellow', 'Red', 'Blue'];

  void initialize() async {
    var uid = (await FirebaseAuth.instance.currentUser()).uid;
    setState(() {
      id = uid;
    });
  }

  void confirmBooking() async {
    _booking.bookDetails(id, _name, _personalno, loungeColor[_value1], slot, _eventDate);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _eventDate = DateTime.now();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    print(_eventDate.year);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? "Edit Note" : "Booking Details"),
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Name',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepOrange, width: 1.0),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepOrange, width: 3.0),
                          borderRadius: BorderRadius.circular(10))),
                  validator: (val) => val.isEmpty ? 'Enter your Name' : null,
                  onChanged: (val) {
                    setState(() => _name = val);
                  }),
              SizedBox(height: 10),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Personal No.',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepOrange, width: 1.0),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepOrange, width: 3.0),
                          borderRadius: BorderRadius.circular(10))),
                  validator: (val) =>
                      val.isEmpty ? 'Enter your Personal No.' : null,
                  onChanged: (val) {
                    setState(() => _personalno = val);
                  }),
              const SizedBox(height: 10.0),
              DropdownButton(
                  value: _value1,
                  items: [
                    DropdownMenuItem(
                      child: Text("Yellow"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Red"),
                      value: 2,
                    ),
                    DropdownMenuItem(child: Text("Blue"), value: 3),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value1 = value;
                    });
                  }),
              const SizedBox(height: 10.0),
              DropdownButton(
                  value: _value2,
                  items: [
                    DropdownMenuItem(
                      child: Text("Slot 1"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Slot 2"),
                      value: 2,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value2 = value;
                      slot = value;
                    });
                  }),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Date (YYYY-MM-DD)"),
                subtitle: Text(
                    "${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}"),
                onTap: () async {
                  DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: _eventDate,
                      firstDate: DateTime(_eventDate.year - 5),
                      lastDate: DateTime(_eventDate.year + 5));
                  if (picked != null) {
                    setState(() {
                      _eventDate = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                  color: Colors.deepOrange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 25),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      confirmBooking();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
