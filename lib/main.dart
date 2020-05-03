import 'package:flutter/material.dart';
import 'package:transporto_registravimas/services/authentication.dart';
import 'package:transporto_registravimas/pages/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Transporto priemonių registravimo elektroninė paslauga',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth()));
  }
}