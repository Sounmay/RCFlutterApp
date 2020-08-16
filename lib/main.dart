import 'package:flutter/material.dart';
import 'package:rcapp/pages/Cart.dart';
import 'package:rcapp/pages/Food.dart';
import 'package:rcapp/pages/NavigationBar.dart';
import 'package:rcapp/pages/add_event.dart';
import 'package:rcapp/pages/address.dart';
import 'package:rcapp/pages/admin_order_confirm.dart';
import 'package:rcapp/pages/booking_calendar.dart';
import 'package:rcapp/pages/confirmOrder.dart';
import 'package:rcapp/pages/orderdetails.dart';
import 'package:rcapp/pages/welcome.dart';
import 'package:rcapp/services/auth.dart';
import 'pages/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:rcapp/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: welcome(),
        routes: {
          '/navigationbar': (context) => NavigationBar(),
          '/bookingcalendar': (context) => Calendar(),
          '/cart': (context) => Cart(),
          '/adminorder': (context) => AdminOrder(),
          '/orderdetails': (context) => OrderDetails(),
          '/wrapper': (context) => Wrapper(),
          "/add_event": (context) => AddEventPage(),
          "/confirmOrder": (context) => ConfirmOrder(),
          "/address" : (context) => AddressForm(),
        },
      ),
    );
  }
}