import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:transporto_registravimas/models/contract.dart';
import 'dart:async';

class VehicleBuyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _VehicleBuyPage();
}

class _VehicleBuyPage extends State<VehicleBuyPage> {
  String certificateNumber;
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String radioItem;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Contract> _contractList;

  @override
  void initState() {
    super.initState();
    _contractList = new List();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text('Transporto priemonės įregistravimas'),
      ),
      body: new ListView(
        children: <Widget>[
          enterCertificate(),
          showButtons(),
        ],
      ),
    );
  }

  Widget enterCertificate() {
    return new Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Text('Įvesti sertifikato numerį:', style: TextStyle(fontSize: 22)),
      ),
      Container(
        width: 250.0,
        child: TextField(
          onChanged: (String value) {
            certificateNumber = value;
          },
          keyboardType: TextInputType.text,
          maxLines: 1,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(0.0),
              borderSide: new BorderSide(),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget showButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MaterialButton(
              height: 40.0,
              minWidth: 150,
              color: Colors.white54,
              onPressed: () {
                manageCertificate(certificateNumber);
              },
              child: Text('Patvirtinti'),
            ),
            MaterialButton(
              height: 40.0,
              minWidth: 150,
              color: Colors.white54,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Atšaukti'),
            ),
          ]),
    );
  }

  manageCertificate(String id) {
    if (id != null) {
      databaseReference
          .child('contract')
          .child(id)
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value == null) {
        } else {
          var arr = snapshot.value;
          databaseReference.child('vehicle').child(arr['carID']).update({
            'statusId': 'Įregistruota',
            // 'userOd':newUser,
          });
          databaseReference.child('contract').child(id).remove();
          message('Transporto priemonės įregistravimas sėkmingas');
        }
      });
    }
  }

  message(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  Widget showSnackBar(BuildContext context) {
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.lightBlue]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }
  }
}
