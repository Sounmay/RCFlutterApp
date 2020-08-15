import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rcapp/CustomWidget/foot_category.dart';
import 'package:rcapp/CustomWidget/menu_category.dart';
import 'package:rcapp/pages/Search.dart';
import 'package:rcapp/pages/storeData.dart';

var cartList = [];

class Orders {
  final String item;
  final int price;
  final int quantity;

  Orders(this.item, this.price, this.quantity);
}

Orders newOrder;

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Menu");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text("Menu"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          )
        ],
      ),
      body: new ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          SizedBox(height: 10.0),
          Search(),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              "Today's Menu",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          FoodCategory(),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              "Categories",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MenuCategories(),
          SizedBox(height: 10.0),
          Text(
            'Chinese',
            style: TextStyle(
                fontSize: 18,
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold),
          ),
          ListPage()
        ],
      ),
    );
  }
}

class Quantity extends StatefulWidget {
  @override
  _QuantityState createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  bool isChecked = false;

  void toggle() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isChecked) {
      return InkWell(
        onTap: () {
          toggle();
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey, width: 0.1),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 2.0, offset: Offset(2.1, 2.2))
            ],
          ),
          height: 25,
          width: 62,
          child: Center(
              child: Text('Add', style: TextStyle(color: Colors.deepOrange))),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          toggle();
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey, width: 0.1),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 2.0, offset: Offset(2.1, 2.2))
            ],
          ),
          height: 25,
          width: 66,
          child: Center(
              child:
              Text('Remove', style: TextStyle(color: Colors.deepOrange))),
        ),
      );
    }
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("chinese").getDocuments();
    print(qn);
    return qn.documents;
  }

  StoreData storeData = StoreData();

  int _cartBadge = 0;

  void addToCart(DocumentSnapshot post) async {
    String item = await post.data["item"];
    int price = await post.data["price"];
    // if ((cartList.singleWhere((element) => element.item == item,
    //         orElse: () => null)) !=
    //     null) {
    //   return;
    // } else {
    //   cartList.add(Orders(item, price, 1));
    // }
    storeData.StoreFoodDetails(item, price, 1);
    setState(() {
      ++_cartBadge;
    });
    print(item);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _data = getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 200,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitDualRing(
                        color: Colors.deepOrange,
                        size: 38,
                      ),
                      SizedBox(height: 20),
                      Text('LOADING',
                          style: TextStyle(fontWeight: FontWeight.w500))
                    ]),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      onTap: () {
                        addToCart(snapshot.data[index]);
                      },
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      addToCart(snapshot.data[index]);
                                    },
                                    icon: Icon(
                                      Icons.radio_button_unchecked,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data[index].data["item"]}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Quantity()
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin:
                                new EdgeInsets.symmetric(horizontal: 50.0),
                                child: Text(
                                  '₹' + '${snapshot.data[index].data["price"]}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          const Divider(
                            color: Colors.grey,
                            height: 2,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}