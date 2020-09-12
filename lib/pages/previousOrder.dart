import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rcapp/models/user.dart';

class PreviousOrder extends StatefulWidget {
  @override
  _PreviousOrderState createState() => _PreviousOrderState();
}

class _PreviousOrderState extends State<PreviousOrder> {
  List<dynamic> orders = [];
  List<dynamic> item = [];
  List<dynamic> quantity = [];
  List<dynamic> total = [];

  void initialData() async {
    var uid = (await FirebaseAuth.instance.currentUser()).uid;
    print(uid);
    var result = await Firestore.instance
        .collection('confirmedOrders')
        .where('id', isEqualTo: uid)
        .getDocuments();
    result.documents.forEach((res) {
      setState(() {
        orders.add(res.data);
        item.add(res.data["item"]);
        quantity.add(res.data["quantity"]);
        total.add(res.data["total"]);
      });
    });
    print(orders[0]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialData();
  }

  @override
  Widget build(BuildContext context) {
    int orderNo = 110;
    if (orders.length == 0 && item.length == 0 && quantity.length == 0) {
      return Container(
        child: Text('No data'),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
          backgroundColor: Colors.deepOrange,
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: orders.length,
          itemBuilder: (_, index) {
            orderNo += index;
            return ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 420.0,
                    width: 370.0,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Order Number : " + "$orderNo",
                              style: TextStyle(
                                  color: Colors.deepOrange, fontSize: 22),
                            ),
                            Flexible(child: Text('${orders[index]["date"]}')),
                          ],
                        ),
                        SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Name : " + "${orders[index]["name"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Personal No. : " +
                                      "${orders[index]["number"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Address : ",
                                        // "${orders[index]["address"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Container(
                                        width: 240,
                                        child: Text(
                                          "${orders[index]["address"]}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ]),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Flexible(
                          child: OrderData(
                              item: item[index], quantity: quantity[index]),
                        ),
                        Text(
                          "Cost : ₹" + "${orders[index]["total"]} ",
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}

class OrderData extends StatefulWidget {
  List item;
  List quantity;
  OrderData({this.item, this.quantity});
  @override
  _OrderDataState createState() => _OrderDataState();
}

class _OrderDataState extends State<OrderData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: ListView.builder(
          itemCount: widget.item.length,
          itemBuilder: (_, index) {
            return Container(
              child: Text('${widget.item[index]}: ${widget.quantity[index]}'),
            );
          }),
    );
  }
}
