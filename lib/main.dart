import 'package:flutter/material.dart';
import 'package:transporto_registravimas/pages/welcome.dart';
import 'package:provider/provider.dart';
import 'package:transporto_registravimas/providers/phone_auth.dart';

void main() {
  runApp(new TPRegistration());
}

class TPRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PhoneAuthDataProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Transporto priemonių registravimo elektroninė paslauga',
        home: new WelcomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}