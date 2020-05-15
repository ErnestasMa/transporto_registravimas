import 'package:flutter/material.dart';
import 'package:transporto_registravimas/services/authentication.dart';
import 'package:transporto_registravimas/pages/root_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  String _selection = '';
  String radioItem = '';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transporto priemonių registravimo elektroninė paslauga'),
      ),
      body: new ListView(
        children: <Widget>[
          showLogo(),
          radiobutton(context),
          _showLoginButton(context),
          _showErrorMessage(),
        ],
      ),
    );
  }

  Widget _showLoginButton(BuildContext context) {
    if (_selection == 'parašas' && _selection != null) {
      return new Container(
          padding: EdgeInsets.all(16.0),
          child: RaisedButton(
            onPressed: () {
              Route route = MaterialPageRoute(
                  builder: (context) => new RootPage(auth: new Auth()));
              Navigator.push(context, route);
            },
            child: Text('Prisijungti'),
          ));
    } else {
      return new Container(
        height: 0.0,
      );
    }
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

  Widget radiobutton(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Pasirinkti būdą asmens tapatybės nustatymui:',
            style: TextStyle(fontSize: 18)),
        RadioListTile(
          groupValue: radioItem,
          title: Text('m.parašu'),
          value: 'm.parašu',
          onChanged: (val) {
            setState(() {
              radioItem = val;
              _errorMessage = '';
              _selection = 'parašas';
            });
          },
        ),
        RadioListTile(
          groupValue: radioItem,
          title: Text('per e.valdžios vartus'),
          value: 'per e.valdžios vartus',
          onChanged: (val) {
            setState(() {
              radioItem = val;
              _errorMessage =
                  'Prisijungimas per e.valdžios vartus nėra galimas';
              _selection = 'vartai';
            });
          },
        ),
      ],
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 15.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}
