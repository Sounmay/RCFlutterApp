import 'package:rcapp/models/event.dart';
import 'package:flutter/material.dart';
import 'package:rcapp/res/event_firestore_service.dart';

class AddEventPage extends StatefulWidget {
  final EventModel note;

  const AddEventPage({Key key, this.note}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _name;
  TextEditingController _personalno;
  TextEditingController _Lounge;
  DateTime _eventDate;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.note != null ? widget.note.name : "");
    _personalno = TextEditingController(text:  widget.note != null ? widget.note.personalno : "");
    _Lounge = TextEditingController(text: widget.note != null ? widget.note.Lounge : "");
    _eventDate = DateTime.now();
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? "Edit Note" : "Booking Details"),
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _name,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter Your Name" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Name",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _personalno,
                  //minLines: 3,
                  //maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter Your Personal Number" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Personal No",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _Lounge,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter The Lounge you want to book (Yellow/Red/Blue) " : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Lounge to book (Yellow/Red/Blue)",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Date (YYYY-MM-DD)"),
                subtitle: Text("${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}"),
                onTap: ()async{
                  DateTime picked = await showDatePicker(context: context, initialDate: _eventDate, firstDate: DateTime(_eventDate.year-5), lastDate: DateTime(_eventDate.year+5));
                  if(picked != null) {
                    setState(() {
                      _eventDate = picked;
                    });
                  }
                },
              ),

              SizedBox(height: 10.0),
              processing
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).primaryColor,
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          processing = true;
                        });
                        if(widget.note != null) {
                          await eventDBS.updateData(widget.note.id,{
                            "Name": _name.text,
                            "personal no": _personalno.text,
                            "Lounge": _Lounge.text,
                            "event_date": widget.note.eventDate
                          });
                        }else{
                          await eventDBS.createItem(EventModel(
                              name: _name.text,
                              personalno: _personalno.text,
                              Lounge: _Lounge.text,
                              eventDate: _eventDate
                          ));
                        }
                        Navigator.pop(context);
                        setState(() {
                          processing = false;
                        });
                      }
                    },
                    child: Text(
                      "Save",
                      style: style.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _personalno.dispose();
    _Lounge.dispose();
    super.dispose();
  }
}