import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:your_shop/models/list_items.dart';
import 'package:your_shop/screen/detail_screen.dart';
import 'package:your_shop/screen/home_screen.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //       statusBarColor: Colors.white.withOpacity(0.0),
  //       statusBarIconBrightness: Brightness.light),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final home = HomeScreen();
  final detail = DetailScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => home,
        'detail': (BuildContext context) => detail,
      },
    );
  }
}
