import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transporto_registravimas/services/verify.dart';
import 'package:transporto_registravimas/providers/phone_auth.dart';
import 'package:provider/provider.dart';
import 'package:transporto_registravimas/utils/widgets.dart';

class PhoneAuthGetPhone extends StatefulWidget {
  final String appName =
      "Transporto priemonių registravimo elektroninė paslauga";

  @override
  _PhoneAuthGetPhoneState createState() => _PhoneAuthGetPhoneState();
}

class _PhoneAuthGetPhoneState extends State<PhoneAuthGetPhone> {
  double _height, _width, _fixedPadding;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-get-phone");

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.025;
    final loader = Provider.of<PhoneAuthDataProvider>(context).loading;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transporto priemonių registravimo sistema',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: _getBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody() => Container(
        child: _getColumnBody(),
      );

  Widget _getColumnBody() => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(bottom: 16.0, left: 25.0, right: 25.0),
            child: Text('Prašome įvesti mobilujį telefono numerį:',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: _fixedPadding,
                right: _fixedPadding,
                bottom: _fixedPadding),
            child: PhoneNumberField(
              controller:
                  Provider.of<PhoneAuthDataProvider>(context, listen: false)
                      .phoneNumberController,
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0, left: 25.0, right: 25.0),
                child: Text('Asmens kodą:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: _fixedPadding,
                right: _fixedPadding,
                bottom: _fixedPadding),
            child: IDNumberField(
              controller:
                  Provider.of<PhoneAuthDataProvider>(context, listen: false)
                      .idNumberController,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: _fixedPadding),
              Icon(Icons.info, color: Colors.black, size: 20.0),
              SizedBox(width: 10.0),
              Expanded(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Pin kodas bus atsiųstas',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: ' tik vieną kartą',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: ' į nurodytą mobilųjį numerį',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                ])),
              ),
              SizedBox(width: _fixedPadding),
            ],
          ),
          SizedBox(height: _fixedPadding * 1.5),
          RaisedButton(
            elevation: 5.0,
            onPressed: startPhoneAuth,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Siųsti',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
        ],
      );

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  startPhoneAuth() async {
    final phoneAuthDataProvider =
        Provider.of<PhoneAuthDataProvider>(context, listen: false);
    phoneAuthDataProvider.phoneNumberController.text =
        '+370' + phoneAuthDataProvider.phoneNumberController.text;
    phoneAuthDataProvider.loading = true;
    bool validPhone = await phoneAuthDataProvider.instantiate(onCodeSent: () {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (BuildContext context) => PhoneAuthVerify()));
    }, onFailed: () {
      _showSnackBar(phoneAuthDataProvider.message);
    }, onError: () {
      _showSnackBar(phoneAuthDataProvider.message);
    });
    if (!validPhone) {
      phoneAuthDataProvider.loading = false;
      _showSnackBar("Neteisingas numeris");
      return;
    }
  }
}
