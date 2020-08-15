import 'package:flutter/material.dart';
import 'package:rcapp/models/address.dart';
import 'package:rcapp/res/address_firestore_service.dart';

class AddAddress extends StatefulWidget {

  final AddressModel note1;
  const AddAddress({Key key, this.note1}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _houseno;
  TextEditingController _streetname;
  TextEditingController _area;
  TextEditingController _city;
  TextEditingController _pincode;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  @override

  void initState() {
    super.initState();
    _houseno = TextEditingController(text: widget.note1 != null ? widget.note1.houseno : "");
    _streetname = TextEditingController(text:  widget.note1 != null ? widget.note1.streetname : "");
    _area = TextEditingController(text: widget.note1 != null ? widget.note1.area : "");
    _city = TextEditingController(text: widget.note1 != null ? widget.note1.city : "");
    _pincode = TextEditingController(text: widget.note1 != null ? widget.note1.pincode : "");

    processing = false;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note1 != null ? "Edit Details" : "Address Details"),
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
                  controller: _houseno,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter Your House Number" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "House No.",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _streetname,
                  //minLines: 3,
                  //maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter Your street name" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Address Line 2",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _area,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter your area " : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Address Line 3",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _city,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter your city " : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "City",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _pincode,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter your pincode " : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Pincode",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
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
                        if(widget.note1 != null) {
                          await addressDBS.updateData(widget.note1.id,{
                            "houseno": _houseno.text,
                            "streetname": _streetname.text,
                            "area": _area.text,
                            "city": _city.text,
                            "pincode": _pincode.text,
                          });
                        }else{
                          await addressDBS.createItem(AddressModel(
                              houseno: _houseno.text,
                              streetname: _streetname.text,
                              area: _area.text,
                              city: _city.text,
                              pincode: _pincode.text,
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
}}
