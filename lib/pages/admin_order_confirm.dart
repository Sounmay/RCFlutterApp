import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rcapp/models/user.dart';
import 'package:rcapp/services/database.dart';
import 'package:provider/provider.dart';

class ConfirmedOrderDetails {
  String name;
  String number;
  int total;
  String address;
}

class AdminOrder extends StatefulWidget {
  @override
  _AdminOrderState createState() => _AdminOrderState();
}

class _AdminOrderState extends State<AdminOrder> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Orders>>.value(
      value: DatabaseService().orders,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
          backgroundColor: Colors.deepOrange,
        ),
        body: NewOrderList(),
      ),
    );
  }
}

class NewOrderList extends StatefulWidget {
  @override
  NewOrderListState createState() => NewOrderListState();
}

class NewOrderListState extends State<NewOrderList> {
  changeConfirmation(bool isConfirmed, String number) async {
    try {
      if (isConfirmed) {
        await Firestore.instance
            .collection("confirmedOrders")
            .document(number)
            .delete();
      } else {
        await Firestore.instance
            .collection("confirmedOrders")
            .document(number)
            .updateData({"isConfirmed": !isConfirmed});
      }
      Navigator.pushReplacementNamed(context, '/adminorder');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    int orderNo = 110;
    final _orderList = Provider.of<List<Orders>>(context) ?? [];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _orderList.length,
      itemBuilder: (_, index) {
        orderNo += index;
        return ListTile(
          contentPadding: EdgeInsets.all(10),
          title: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment.topLeft,
                height: 420.0,
                width: 370.0,
                margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Order Number : " + "$orderNo",
                          style:
                              TextStyle(color: Colors.deepOrange, fontSize: 22),
                        ),
                        Text("Aug 4th 2020"),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Name : " + "${_orderList[index].name}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Personal No. : " +
                                    "${_orderList[index].number}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "Address : " + "${_orderList[index].address}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "Cost : ₹" +
                                "${_orderList[index].total} " +
                                "${_orderList[index].item}" +
                                " : " +
                                "${_orderList[index].qty}",
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/orderdetails');
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          child: Text('View'),
                          color: Colors.white,
                        ),
                        FlatButton(
                          onPressed: () {
                            changeConfirmation(_orderList[index].isConfirmed,
                                _orderList[index].number);
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          child: Text(_orderList[index].isConfirmed
                              ? 'Confirm'
                              : 'Delete'),
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
