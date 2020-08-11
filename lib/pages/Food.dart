import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcapp/CustomWidget/foot_category.dart';
import 'package:rcapp/CustomWidget/menu_category.dart';
import 'package:rcapp/pages/Search.dart';

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  int FQty = 0;

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Menu");

  @override
  Widget build(BuildContext context) {
    Widget image_carousel2 = new Container(
        padding: EdgeInsets.all(10),
        height: 150.0,
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('assets/6.jpg'),
            AssetImage('assets/7.jpg'),
            AssetImage('assets/8.jpg'),
          ],
          autoplay: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          borderRadius: true,
          indicatorBgPadding: 10.0,
        ));
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: cusSearchBar,
        actions: <Widget>[
          IconButton(
            icon: cusIcon,
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search for a food",
                      hintStyle: TextStyle(
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  );
                } else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text("Menu");
                }
              });
            },
          )
        ],
      ),
      body: new ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
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
          SizedBox(height: 10.0),
          MenuCategories(),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'Chinese',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold),
            ),
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
  int FQty = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.remove,
          ),
          onPressed: () {
            setState(() {
              if (FQty > 0) {
                FQty -= 1;
              }
            });
          },
        ),
        Text(
          '$FQty',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {
            setState(() {
              FQty += 1;
            });
          },
        ),
      ],
    );
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
              return Center(
                child: Text("Loading"),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.radio_button_checked,
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
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
                    );
                  });
            }
          }),
    );
  }
}
