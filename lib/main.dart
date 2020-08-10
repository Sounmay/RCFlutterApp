import 'package:flutter/material.dart';
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
        home: wrapper(),
      ),
    );
  }
}
