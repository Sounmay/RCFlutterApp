import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:rcapp/pages/Add_Food.dart';
import 'package:rcapp/pages/Food_List.dart';

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {

  List<FoodList> _foodlist = foodlist;

  int FQty = 0;

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
                        hintText: "Search for a food",
                        hintStyle: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic, color: Colors.white),
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
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 20),
            child:Text(
              "Menu",
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 20,
              ),
            ),
          ),
          Column(
            children: _foodlist.map(_buildFoodItems).toList(),
          ),
        ],
      ),
    );
  }
}

Widget _buildFoodItems(FoodList foodList){
  return Container(
    child: AddFood(
      id: foodList.id,
      Name: foodList.Name,
      price: foodList.price,
    ),
  );
}
