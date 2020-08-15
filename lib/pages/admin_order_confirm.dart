import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminOrder extends StatefulWidget {
  @override
  _AdminOrderState createState() => _AdminOrderState();
}

class _AdminOrderState extends State<AdminOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: OrderList(),
    );
  }
}

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  Future _orderdata;

  Future getOrders() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn =
    await firestore.collection("confirmedOrders").getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderdata = getOrders();
  }

  @override
  Widget build(BuildContext context) {
    int orderNo = 111;
    // return Scaffold(
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //         elevation: 10.0,
    //         backgroundColor: Colors.deepOrange,
    //         title: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: <Widget>[
    //               Text('Orders'),
    //             ])),
    return FutureBuilder(
        future: _orderdata,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 550,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: SpinKitCubeGrid(
                          color: Colors.deepOrange,
                          size: 38,
                        ),
                      ),
                      Center(
                        child: Text('LOADING',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      )
                    ]),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                orderNo += index;
                return ListTile(
                  contentPadding: EdgeInsets.all(10),
                  title: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Container(
                        alignment: Alignment.topLeft,
                        height: 220.0,
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
                                  style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 22),
                                ),
                                Text("Aug 4th 2020"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Name : " +
                                        "${snapshot.data[index].data["name"]}",
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
                                        "${snapshot.data[index].data["number"]}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Cost : ₹" +
                                        "${snapshot.data[index].data["total"]}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 22),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/orderdetails');
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(10.0)),
                                  child: Text('View'),
                                  color: Colors.white,
                                ),
                                FlatButton(
                                  onPressed: () {},
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(10.0)),
                                  child: Text('Confirm'),
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
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Icon(
                    Icons.assessment,
                    size: 50,
                  ),
                ),
                Center(
                  child: Text(
                    'No orders left...',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          }
        });
    // );
  }
}