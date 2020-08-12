import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:rcapp/CustomWidget/todays_menucategory.dart';
import 'package:rcapp/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
        padding: EdgeInsets.all(10),
        height: 200.0,
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(200.0)),
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('assets/23.jpg'),
            AssetImage('assets/19.jpg'),
            AssetImage('assets/20.jpg'),
            AssetImage('assets/21.jpg'),
            AssetImage('assets/22.jpg'),
            AssetImage('assets/18.jpg'),
            AssetImage('assets/24.jpg'),
            AssetImage('assets/25.jpg'),
          ],
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          borderRadius: true,
          indicatorBgPadding: 10.0,
        ));

    Widget image_carousel2 = new Container(
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
        ));

    Widget image_carousel3 = new Container(
        height: 150.0,
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('assets/9.jpg'),
            AssetImage('assets/2.jpg'),
            AssetImage('assets/3.jpg'),
          ],
          autoplay: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Home'),
            ]),
      ),
      drawer: Drawer(child: Text('hello')),
      body: new ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        children: <Widget>[
          SizedBox(height: 4),
          InkWell(
            onTap: () {},
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Rourkela Club Menu',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 15,
                        decoration: TextDecoration.underline),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.picture_as_pdf),
                  )
                ]),
          ),
          image_carousel,
          SizedBox(height: 20.0),
          Text(
            "  Notice Board",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          HomeListPage(),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "  Today's Menu",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 130.0),
              OutlineButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                child: Text('View'),
                color: Colors.amber,
              ),
            ],
          ),
          SizedBox(height: 7.0),
          TodaysMenuCategory(),
          SizedBox(height: 20.0),
          Text(
            "  Upcoming Events",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          TodaysMenuCategory(),
          SizedBox(height: 50)
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _auth.signOut();
          },
          child: Text('Sign Out')),
    );
  }
}

class HomeListPage extends StatefulWidget {
  @override
  _HomeListPageState createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("noticeBoard").getDocuments();
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
      height: 220,
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading"),
              );
            } else {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      '${snapshot.data[index].data["title"]}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '${snapshot.data[index].data["subtitle"]}',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  )
                                ]),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.picture_as_pdf),
                            )
                          ]),
                    );
                  });
            }
          }),
    );
  }
}
