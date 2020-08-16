import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rcapp/CustomWidget/todays_menucategory.dart';
import 'package:rcapp/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  bool areYouadmin;
  String userName;
  String userNumber;

  Future getAdmin() async {
    try {
      var userkaabba = (await FirebaseAuth.instance.currentUser()).uid;
      var dat = await Firestore.instance
          .collection("userInfo")
          .document(userkaabba)
          .get();
      setState(() {
        areYouadmin = dat.data["isAdmin"];
        userName = dat.data["name"];
        userNumber = dat.data["number"];
      });
      // .then((value) => value.data["IsAdmin"]);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdmin();
  }

  @override
  Widget build(BuildContext context) {
    // final userData = Provider.of<UserData>(context);

    // getAdmin();

    Widget imageCarousel = new Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        height: 180.0,
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
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            height: 100,
            child: LoadingData(auth: _auth),
          ),
        ),
      ),
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
                        fontSize: 10,
                        decoration: TextDecoration.underline),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.picture_as_pdf),
                  )
                ]),
          ),
          imageCarousel,
          SizedBox(height: 20.0),
          Text(
            "  Notice Board",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
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
             /* OutlineButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/address');
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                child: Text('View'),
                color: Colors.amber,
              ), */
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
          Container(
            height: 150,
            decoration: BoxDecoration(color: Colors.blue[50]),
            child: Center(child: Text('No Events')),
          ),
          SizedBox(height: 50)
        ],
      ),
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
              return Container(
                height: 200,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitDoubleBounce(
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

class AdminOption extends StatefulWidget {
  bool areYouadmin;
  AdminOption({this.areYouadmin});
  @override
  _AdminOptionState createState() => _AdminOptionState();
}

class _AdminOptionState extends State<AdminOption> {
  @override
  Widget build(BuildContext context) {
    if (isAdminglobal || widget.areYouadmin == true) {
      return Container(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/adminorder');
          },
          child: Text(
            'Admin Orders',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      );
    } else if (isAdminglobal == null || isAdminglobal == false) {
      return Container(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
        child: InkWell(
          onTap: () {},
          child: Text(
            'Notification',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      );
    }
  }
}

class LoadingData extends StatefulWidget {
  var auth;
  LoadingData({this.auth});
  @override
  _LoadingDataState createState() => _LoadingDataState();
}

class _LoadingDataState extends State<LoadingData> {
  Future _userData;

  Future getAdmin() async {
    var userkaabba = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance
        .collection("userInfo")
        .document(userkaabba)
        .get();
    // setState(() {
    //   areYouadmin = dat.data["isAdmin"];
    //   userName = dat.data["name"];
    //   userNumber = dat.data["number"];
    // });
    // .then((value) => value.data["IsAdmin"]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _userData = getAdmin();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Container(
        child: FutureBuilder(
            future: _userData,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SpinKitDoubleBounce(
                          color: Colors.deepOrange,
                          size: 38,
                        ),
                        SizedBox(height: 20),
                        Text('LOADING',
                            style: TextStyle(fontWeight: FontWeight.w500))
                      ]),
                );
              } else {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${snapshot.data["name"]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                'Personal No. ${snapshot.data["number"]}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ])
                      ]),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                        child: InkWell(
                            onTap: () {},
                            child: Text(
                              'My Bookings',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                        child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Previous Orders',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                      SizedBox(height: 10),
                      AdminOption(areYouadmin: snapshot.data["isAdmin"]),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                        child: InkWell(
                            onTap: () async {
                              await _auth.signOut();
                            },
                            child: Text(
                              'Sign Out',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )),
                      ),
                    ]);
              }
            }));
  }
}