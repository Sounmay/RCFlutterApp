import 'package:flutter/material.dart';
import 'package:rcapp/pages/Cart.dart';
import 'package:rcapp/pages/CategoryMenuList/Accompaniment_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/All_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Biryani_MenuList.dart';
import 'package:rcapp/pages/CategoryMenuList/Bread_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Breakfast_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Burger_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Chinese_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/FriedRiceAndNoodles_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/MainCourse_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Pasta_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Pizza_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Roll_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Sandwich_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Snacks_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Soup_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Starter_Menu.dart';
import 'package:rcapp/pages/CategoryMenuList/Tandoori_Menu.dart';
import 'package:rcapp/pages/Food.dart';
import 'package:rcapp/pages/NavigationBar.dart';
import 'package:rcapp/pages/add_event.dart';
import 'package:rcapp/pages/address.dart';
import 'package:rcapp/pages/admin_order_confirm.dart';
import 'package:rcapp/pages/booking_calendar.dart';
import 'package:rcapp/pages/confirmOrder.dart';
import 'package:rcapp/pages/orderdetails.dart';
import 'package:rcapp/pages/uploadImage.dart';
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

          //routes for different categories of food
          "/allmenu" : (context) => AllMenu(),
          "/biryanimenu" : (context) => Biryani_MenuList(),
          "/breadmenu" : (context) => Bread_MenuList(),
          "/breakfastmenu" : (context) => Breakfast_MenuList(),
          "/burgermenu" : (context) => Burger_MenuList(),
          "/chinesemenu" : (context) => ChineseMenuList(),
          "/friedriceandnoodlesmenu" : (context) => FriedRiceAndNoodles_MenuList(),
          "/maincoursemenu" : (context) => MainCourse_MenuList(),
          "/pastamenu" : (context) => Pasta_MenuList(),
          "/pizzamenu" : (context) => Pizza_MenuList(),
          "/rollmenu" : (context) => Roll_MenuList(),
          "/sandwichmenu" : (context) => Sandwich_MenuList(),
          "/snacksmenu" : (context) => Snacks_MenuList(),
          "/soupmenu" : (context) => Soup_MenuList(),
          "/startermenu" : (context) => StarterMenuList(),
          "/tandoorimenu" : (context) => Tandoori_MenuList(),
          "/accompanimentmenu" : (context) => Accompaniment_Menu(),

          //Routes for admin
          "/uploadImage" : (context) => UploadImage()
        },
      ),
    );
  }
}