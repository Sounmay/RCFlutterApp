import 'package:flutter/material.dart';
import 'package:rcapp/pages/Cart.dart';
import 'package:rcapp/pages/Home.dart';
import 'package:rcapp/services/auth.dart';
import 'pages/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:rcapp/models/user.dart';
import 'pages/Food.dart';
import 'pages/booking_calendar.dart';
import 'pages/Cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: wrapper(),
        routes: {

          '/food': (context) => Food(),
          '/bookingcalendar': (context) => Calendar(),
          '/cart': (context) => Cart(),
        },
      ),
    );
  }
}
