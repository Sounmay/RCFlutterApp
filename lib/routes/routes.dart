import '../pages/BlueL.dart';
import '../pages/Cart.dart';
import '../pages/CategoryMenuList/Accompaniment_Menu.dart';
import '../pages/CategoryMenuList/All_Menu.dart';
import '../pages/CategoryMenuList/Biryani_MenuList.dart';
import '../pages/CategoryMenuList/Bread_Menu.dart';
import '../pages/CategoryMenuList/Breakfast_Menu.dart';
import '../pages/CategoryMenuList/Burger_Menu.dart';
import '../pages/CategoryMenuList/Chinese_Menu.dart';
import '../pages/CategoryMenuList/FriedRiceAndNoodles_Menu.dart';
import '../pages/CategoryMenuList/MainCourse_Menu.dart';
import '../pages/CategoryMenuList/Pasta_Menu.dart';
import '../pages/CategoryMenuList/Pizza_Menu.dart';
import '../pages/CategoryMenuList/Roll_Menu.dart';
import '../pages/CategoryMenuList/Sandwich_Menu.dart';
import '../pages/CategoryMenuList/Snacks_Menu.dart';
import '../pages/CategoryMenuList/Soup_Menu.dart';
import '../pages/CategoryMenuList/Starter_Menu.dart';
import '../pages/CategoryMenuList/Tandoori_Menu.dart';
import '../pages/Coluseum.dart';
import '../pages/Milan.dart';
import '../pages/MilapL.dart';
import '../pages/NavigationBar.dart';
import '../pages/YellowL.dart';
import '../pages/add_event.dart';
import '../pages/address.dart';
import '../pages/adminBooking.dart';
import '../pages/admin_order_confirm.dart';
import '../pages/booking_calendar.dart';
import '../pages/mainhall.dart';
import '../pages/previousBooking.dart';
import '../pages/previousOrder.dart';
import '../pages/uploadImage.dart';
import '../pages/uploadPdf.dart';
import '../pages/wrapper.dart';

final routes = {
  '/navigationbar': (context) => NavigationBar(),
  '/bookingcalendar': (context) => Calendar(),
  '/cart': (context) => Cart(),
  '/adminorder': (context) => AdminOrder(),
  // '/orderdetails': (context) => OrderDetails(),
  '/wrapper': (context) => Wrapper(),
  "/add_event": (context) => AddEventPage(),
  "/address": (context) => AddressForm(),
  "/previousOrder": (context) => PreviousOrder(),
  "/previousBooking": (context) => PreviousBooking(),
  "/adminBooking": (context) => AdminBooking(),
  // "/previousOrder": (context) => PreviousOrderDetails(),

  //routes for different categories of food
  "/allmenu": (context) => AllMenu(),
  "/biryanimenu": (context) => Biryani_MenuList(),
  "/breadmenu": (context) => Bread_MenuList(),
  "/breakfastmenu": (context) => Breakfast_MenuList(),
  "/burgermenu": (context) => Burger_MenuList(),
  "/chinesemenu": (context) => ChineseMenuList(),
  "/friedriceandnoodlesmenu": (context) => FriedRiceAndNoodles_MenuList(),
  "/maincoursemenu": (context) => MainCourse_MenuList(),
  "/pastamenu": (context) => Pasta_MenuList(),
  "/pizzamenu": (context) => Pizza_MenuList(),
  "/rollmenu": (context) => Roll_MenuList(),
  "/sandwichmenu": (context) => Sandwich_MenuList(),
  "/snacksmenu": (context) => Snacks_MenuList(),
  "/soupmenu": (context) => Soup_MenuList(),
  "/startermenu": (context) => StarterMenuList(),
  "/tandoorimenu": (context) => Tandoori_MenuList(),
  "/accompanimentmenu": (context) => Accompaniment_Menu(),

  // lounge routes
  "/bluelounge": (context) => BlueLounge(),
  "/yellowlounge": (context) => YellowLounge(),
  "/milanlounge": (context) => MilanLounge(),
  "/milaplounge": (context) => MilapLounge(),
  "/coluseum": (context) => Coluseum(),
  "/mainhall" : (context) => MainHall(),

  //Routes for admin
  "/uploadImage": (context) => UploadImage(),
  "/uploadPdf": (context) => UploadPdf()
};