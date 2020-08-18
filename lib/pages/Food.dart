import 'package:flutter/material.dart';
import 'package:rcapp/CustomWidget/foot_category.dart';
import 'package:rcapp/models/user.dart';
import 'package:rcapp/pages/NavigationBar.dart';
import 'package:rcapp/pages/Search.dart';
import 'package:rcapp/pages/storeData.dart';

// var cartList = [];

// class Orders {
//   final String item;
//   final int price;
//   final int quantity;

//   Orders(this.item, this.price, this.quantity);
// }

// Orders newOrder;

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
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      "Categories: ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/allmenu');
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Text('Full Menu'),
                    color: Colors.orange,
                  ),
                ],
              ),
              ListPage(update: update),
            ],
          ),
        ),
        SizedBox(height: 10.0),
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
    return Container(
        margin: const EdgeInsets.all(10.0),
        height: 400.0,
        width: double.infinity,
        child: new Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/maincoursemenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/30.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/breadmenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/40.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/biryanimenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/28.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/tandoorimenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/29.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/chinesemenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/38.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/friedriceandnoodlesmenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/39.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/rollmenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/33.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/pizzamenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/34.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/snacksmenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/27.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/sandwichmenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/31.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/burgermenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/32.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/pastamenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/35.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/soupmenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/36.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/accompanimentmenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/37.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/startermenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/41.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/breakfastmenu");
                    },
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text('test'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new AssetImage("assets/26.jpg"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ],
        ));
  }
}
