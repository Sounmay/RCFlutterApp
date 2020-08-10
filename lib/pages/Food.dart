import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  int FQty = 0,
      FQty1 = 0,
      FQty2 = 0,
      FQty3 = 0,
      FQty4 = 0,
      FQty5 = 0,
      FQty6 = 0,
      FQty7 = 0,
      FQty8 = 0,
      FQty9 = 0,
      FQty10 = 0,
      FQty11 = 0,
      FQty12 = 0,
      FQty13 = 0,
      FQty14 = 0,
      FQty15 = 0,
      FQty16 = 0;

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Menu");

  @override
  Widget build(BuildContext context) {
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
                        hintText: "Search for a food"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
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
        children: <Widget>[
          //_children[_currentIndex],
          SizedBox(height: 10.0),
          Text(
            "Today's Menu",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          image_carousel2,
          SizedBox(height: 10.0),
          Text(
            "  Breakfast",
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 20,
            ),
          ),
          Column(
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
                    "Vada Sambar",
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
                  Text(
                    '$FQty',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
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
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Idli Sambar",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty1 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty1',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty1 > 0) {
                          FQty1 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Upama",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty2 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty2',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty2 > 0) {
                          FQty2 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Paper Dosa",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty3 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty3',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty3 > 0) {
                          FQty3 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Masala Dosa",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty4 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty4',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty4 > 0) {
                          FQty4 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Poori and Sabzi",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty5 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty5',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty5 > 0) {
                          FQty5 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Cheese Dosa",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty6 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty6',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty6 > 0) {
                          FQty6 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Onion Masala Dosa",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty7 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty7',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty7 > 0) {
                          FQty7 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Onion Butter Masala Dosa",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty8 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty8',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty8 > 0) {
                          FQty8 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Club Special Dosa",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty9 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty9',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty9 > 0) {
                          FQty9 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Paneer Dosa",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty10 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty10',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty10 > 0) {
                          FQty10 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Plain Uttapam",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty11 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty11',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty11 > 0) {
                          FQty11 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Masala Uttapam",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty12 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty12',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty12 > 0) {
                          FQty12 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Tomato Uttapam",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty13 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty13 > 0) {
                          FQty13 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Onion Uttapam",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty14 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty14',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty14 > 0) {
                          FQty14 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Paneer Uttapam",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty15 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty15',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty15 > 0) {
                          FQty15 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Chhole Bhature",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        FQty16 += 1;
                      });
                    },
                  ),
                  Text(
                    '$FQty16',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FQty16 > 0) {
                          FQty16 -= 1;
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
