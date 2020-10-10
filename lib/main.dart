import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:rcapp/pages/welcome.dart';
import 'package:rcapp/routes/routes.dart';
import 'package:rcapp/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:rcapp/models/user.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: welcome(),
        routes: routes,
      ),
    );
  }
}
