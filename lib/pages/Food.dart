import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rcapp/CustomWidget/foot_category.dart';
import 'package:rcapp/CustomWidget/menu_category.dart';
import 'package:rcapp/models/user.dart';
import 'package:rcapp/pages/Search.dart';
import 'package:rcapp/pages/storeData.dart';
import 'package:provider/provider.dart';
import 'package:rcapp/services/database.dart';

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
  StoreData dataforCart = StoreData();
  int total = 0;

  int qty = 0;
  List<int> qtyList = List<int>();

  void update() {
    Map<String, int> qtyCart = dataforCart.retrieveQtyDetails();
    Map<String, int> foodDetail = dataforCart.retrieveFoodDetails();

    setState(() {
      qty = 0;
      qtyCart.forEach((key, value) {
        qty += value;
        qtyList.add(value);
      });
      foodDetail.forEach((k, v) => total = total + v * qtyCart[k]);
    });
  }

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Menu");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Menu>>.value(
      value: DatabaseService().chinese,
      child: Scaffold(
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
        body: Column(children: <Widget>[
          Expanded(
            child: new ListView(
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
                Container(
                  width: double.infinity,
                  child: Text(
                    '   Menu: (Tap to add to cart)',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListPage(update: update),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 54,
            decoration: BoxDecoration(color: Colors.deepOrange),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$qty ' + '  item ' + '|' + ' ' + '₹ ' + '$total',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: (() => Navigator.pushNamed(context, '/cart')),
                    child: Text(
                      'VIEW CART',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
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
    if (isChecked) {
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
  final update;
  ListPage({this.update});
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  StoreData storeData = StoreData();

  int _cartBadge = 0;

  void addToCart(Menu post) {
    String item = post.item;
    int price = post.price;

    storeData.StoreFoodDetails(item, price, 1);
    setState(() {
      ++_cartBadge;
    });
    print(item);
  }

  @override
  Widget build(BuildContext context) {
    final _menuList = Provider.of<List<Menu>>(context) ?? [];
    if (_menuList.length == 0) {
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
              Text('LOADING', style: TextStyle(fontWeight: FontWeight.w500))
            ]),
      );
    } else {
      return Container(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _menuList.length,
              itemBuilder: (_, index) {
                return ListTile(
                  onTap: () {
                    addToCart(_menuList[index]);
                    widget.update();
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
                                  addToCart(_menuList[index]);
                                },
                                icon: Icon(
                                  Icons.radio_button_unchecked,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                '${_menuList[index].item}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          // Quantity()
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: new EdgeInsets.symmetric(horizontal: 50.0),
                            child: Text(
                              '₹' + '${_menuList[index].price}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
              }));
    }
  }
}