import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rcapp/models/user.dart';

class PreviousBooking extends StatefulWidget {
  @override
  _PreviousBookingState createState() => _PreviousBookingState();
}

class _PreviousBookingState extends State<PreviousBooking> {
  List<dynamic> bookings = [];

  String name = '';
  String number = '';
  String lounge = '';
  int slot;
  int documentlength = 1;

  void initialData() async {
    var uid = (await FirebaseAuth.instance.currentUser()).uid;
    var result = await Firestore.instance
        .collection('BookingDetails')
        .where('id', isEqualTo: uid)
        .getDocuments();
    setState(() {
      documentlength = result.documents.length;
    });
    result.documents.forEach((res) {
      setState(() {
        bookings.add(res.data);
        name = res.data["name"];
        // item.add(res.data["item"]);
        number = res.data["number"];
        // quantity.add(res.data["quantity"]);
        lounge = res.data["lounge"];
        // total.add(res.data["total"]);
        slot = res.data["slot"];
      });
    });
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
    if (bookings.length == 0 && documentlength == 1) {
      return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              SpinKitCircle(color: Colors.deepOrange, size: 65),
              Text('Loading data')
            ])),
      );
    } else if (documentlength == 0) {
      return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Icon(Icons.all_inclusive),
              Text('No data')
            ])),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Booking'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: bookings.length,
            itemBuilder: (_, index) {
              orderNo += index;
              return ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 220.0,
                      width: 370.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "#$orderNo",
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 22),
                              ),
                              Flexible(
                                  child: Text('${bookings[index]["date"]}')),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Name : " + "${bookings[index]["name"]}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Personal No. : " +
                                          "${bookings[index]["number"]}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Lounge : " +
                                          "${bookings[index]["lounge"]}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Slot: ${bookings[index]["slot"]}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ]),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}

// class OrderData extends StatefulWidget {
//   List item;
//   List quantity;
//   OrderData({this.item, this.quantity});
//   @override
//   _OrderDataState createState() => _OrderDataState();
// }

// class _OrderDataState extends State<OrderData> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
//       height: 290,
//       child: ListView.builder(
//           itemCount: widget.item.length,
//           itemBuilder: (_, index) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                     child: Row(children: <Widget>[
//                   Text('${index + 1}) '),
//                   Text('${widget.item[index]} '),
//                 ])),
//                 Text('${widget.quantity[index]}'),
//               ],
//             );
//           }),
//     );
//   }
// }

// class PreviousOrderDetails extends StatefulWidget {
//   final int orderNo;
//   final int total;
//   final String address;
//   final String name;
//   final String number;
//   final String date;
//   final List item;
//   final List quantity;
//   PreviousOrderDetails(
//       {this.orderNo,
//       this.total,
//       this.address,
//       this.name,
//       this.number,
//       this.date,
//       this.item,
//       this.quantity});
//   @override
//   _PreviousOrderDetailsState createState() => _PreviousOrderDetailsState();
// }

// class _PreviousOrderDetailsState extends State<PreviousOrderDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.deepOrange,
//           title: Text('Details'),
//         ),
//         body: Container(
//           padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
//           decoration: BoxDecoration(color: Colors.grey[300]),
//           child: ListTile(
//             contentPadding: EdgeInsets.all(10),
//             title: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Colors.grey)),
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 20.0),
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     height: 500.0,
//                     width: 370.0,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                     ),
//                     child: Column(
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               "#${widget.orderNo}",
//                               style: TextStyle(
//                                   color: Colors.deepOrange, fontSize: 22),
//                             ),
//                             Flexible(child: Text('${widget.date}')),
//                           ],
//                         ),
//                         SizedBox(height: 8),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(
//                                   "${widget.name}",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 8),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(
//                                   "Personal No. :",
//                                   style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                   child: Text(
//                                     "${widget.number}",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Text(
//                                         "Delivered To : ",
//                                         style: TextStyle(
//                                             color: Colors.grey,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                       Container(
//                                         width: 300,
//                                         child: Padding(
//                                           padding:
//                                               EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                           child: Text(
//                                             "${widget.address}",
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                         ),
//                                       )
//                                     ]),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Menu :',
//                               style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500),
//                             )),
//                         Container(
//                           padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text('Item Name',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w400,
//                                       decoration: TextDecoration.underline)),
//                               Text('Quantity',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w400,
//                                       decoration: TextDecoration.underline))
//                             ],
//                           ),
//                         ),
//                         Flexible(
//                           child: OrderData(
//                               item: widget.item, quantity: widget.quantity),
//                         ),
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 "Cost : ₹" + "${widget.total} ",
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 22),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               PreviousOrderDetails()));
//                                 },
//                                 child: Container(
//                                   child: Text('Know More',
//                                       style: TextStyle(
//                                           color: Colors.deepOrange,
//                                           decoration:
//                                               TextDecoration.underline)),
//                                 ),
//                               )
//                             ]),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
