import 'package:flutter/material.dart';
import 'package:rcapp/pages/Food.dart';
import 'package:rcapp/pages/order_cart.dart';
import 'package:rcapp/pages/storeData.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // StoreData storeData = StoreData();
  int total = 0;
  int totalquantity = 1;

  StoreData storeDataforCart = StoreData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateTotal();
  }

  List<int> qtyList = List<int>();

  void updateTotal() {
    Map<String, int> foodDetail = storeDataforCart.retrieveFoodDetails();
    Map<String, int> qtyDetail = storeDataforCart.retrieveQtyDetails();

    total = 0;

    setState(() {
      qtyDetail.forEach((key, value) => qtyList.add(value));
      foodDetail.forEach((k, v) => total = total + v * qtyDetail[k]);
    });
  }

  void removeItem(String item) {
    // if ((cartList.singleWhere((element) => element.item == item,
    //         orElse: () => null)) !=
    //     null) {
    //   return;
    // } else {
    //   cartList.add(Orders(item, price, 1));
    // }
    storeDataforCart.removeFoodDetails(item);
    updateTotal();
    print(item);
  }

  void quantityIncreement(String foodName) {
    storeDataforCart.increaseQty(foodName);
    updateTotal();
  }

  void quantityDecreement(String foodName) {
    storeDataforCart.decreaseQty(foodName);
    updateTotal();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> _foodNamePrice = storeDataforCart.retrieveFoodDetails();
    Map<String, int> _foodQtyPrice = storeDataforCart.retrieveQtyDetails();
    updateTotal();
    return Scaffold(
        appBar: AppBar(
          elevation: 10.0,
          backgroundColor: Colors.deepOrange,
          title: Text('Cart'),
        ),
        body: Column(children: <Widget>[
          SizedBox(height: 30),
          OrderCard(total: total),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _foodNamePrice.keys.length,
                itemBuilder: (BuildContext context, index) {
                  String keyname = _foodNamePrice.keys.elementAt(index);
                  int price = _foodNamePrice[keyname];
                  int qty = _foodQtyPrice[keyname];
                  return ListTile(
                    onTap: () {
                      removeItem(keyname);
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
                                    print(keyname);
                                  },
                                  icon: Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  keyname,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            QuantityInCart(
                                index: index,
                                price: price,
                                qtyList: qtyList,
                                qty: qty,
                                keyname: keyname,
                                quantityDecreement: quantityDecreement,
                                quantityIncreement: quantityIncreement)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin:
                              new EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text(
                                '₹' + '$price' + '   Quantity: ' + '$qty',
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
                }),
          ),
          Container(
              width: double.infinity,
              height: 50,
              child:FlatButton(
                  color: Colors.deepOrange,
                  onPressed: () {
                    Navigator.pushNamed(context, '/confirmOrder');
                  },
                  child: Text('Proceed to Pay', style: TextStyle(color: Colors.white),))
          ),
        ]));
  }
}

class QuantityInCart extends StatefulWidget {
  int index;
  int price;
  int qty;
  List<int> qtyList;
  String keyname;
  final quantityIncreement;
  final quantityDecreement;

  QuantityInCart(
      {this.index,
        this.price,
        this.qtyList,
        this.qty,
        this.keyname,
        this.quantityDecreement,
        this.quantityIncreement});
  @override
  _QuantityInCartState createState() => _QuantityInCartState();
}

class _QuantityInCartState extends State<QuantityInCart> {
  @override
  Widget build(BuildContext context) {
    if (widget.qtyList[widget.index] == 0) {
      return InkWell(
        onTap: () {
          print(widget.keyname);
          widget.quantityIncreement(widget.keyname);
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
      return Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey, width: 0.1),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.1, 2.2))
              ],
            ),
            height: 25,
            width: 30,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.remove,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () {
                if (widget.qtyList[widget.index] > 0) {
                  print(widget.key);
                  widget.quantityDecreement(widget.keyname);
                }
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey, width: 0.1),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.1, 2.2))
              ],
            ),
            height: 28,
            width: 33,
            child: Text(
              '${widget.qty}',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          // Text(
          //   '$FQty',
          //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          // ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey, width: 0.1),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.1, 2.2))
              ],
            ),
            height: 25,
            width: 30,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.add,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () {
                print(widget.index);
                if (widget.qtyList[widget.index] > 0) {
                  print(widget.keyname);
                  widget.quantityIncreement(widget.keyname);
                }
              },
            ),
          ),
        ],
      );
    }
  }
}