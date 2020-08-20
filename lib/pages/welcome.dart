import 'package:flutter/material.dart';
import 'package:transporto_registravimas/services/get_phone.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transporto priemonių registravimo sistema',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          showWelcome(),
          showLogo(),
          _showLoginButton(context),
        ],
      ),
    );
  }

  Widget _showLoginButton(BuildContext context) {
    return new Container(
        padding:
            EdgeInsets.only(left: 32.0, top: 400, bottom: 16.0, right: 32.0),
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            Route route = MaterialPageRoute(
                builder: (context) => new PhoneAuthGetPhone());
            Navigator.push(context, route);
          },
          child: Text('Pradėti'),
        ));
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/images/car.png'),
        ),
      ),
    );
  }

  Widget showWelcome() {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: new Text('Sveiki,', style: TextStyle(fontSize: 42))),
        ],
      ),
    );
  }
}
