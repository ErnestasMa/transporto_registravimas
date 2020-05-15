import 'package:flutter/material.dart';

class VehicleSellingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _VehicleSellingPage();
}

class _VehicleSellingPage extends State<VehicleSellingPage> {

  String radioItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transporto priemonių registravimo elektroninė paslauga'),
      ),
      body: new ListView(
        children: <Widget>[
          enterPriceField(),
          enterVehicleKm(),
          enterNumber(),
          enterEmail(),
          showOptions(),
          showButtons(),

          //radiobutton(context),
          // _showLoginButton(context, selection),
          //_showErrorMessage(),
        ],
      ),
    );
  }

  Widget enterPriceField() {
    return new Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Įvesti pardavimo kainą, Eur:',
            style: TextStyle(fontSize: 22)),
      ),
      Container(
        width: 250.0,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(0.0),
              borderSide: new BorderSide(
              ),
            ),
              ),
        ),
      ),
    ]);
  }

  Widget enterVehicleKm() {
    return new Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Įvesti transporto priemonės ridą, km:',
            style: TextStyle(fontSize: 22)),
      ),
      Container(
        width: 250.0,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(0.0),
              borderSide: new BorderSide(
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget enterNumber() {
    return new Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Įvesti pirkėjo mobilaus telefono Nr.:',
            style: TextStyle(fontSize: 22)),
      ),
      Container(
        width: 250.0,
        child: TextField(
          maxLines: 1,
          decoration: new InputDecoration(
            hintText: "+370 6",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(0.0),
              borderSide: new BorderSide(
              ),
            ),
          ),
        ),
      ),
    ]);
  }
  Widget enterEmail() {
    return new Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Ir (ar) pirkėjo el.pašto adresą:',
            style: TextStyle(fontSize: 22)),
      ),
      Container(
        width: 250.0,
        child: TextField(
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(0.0),
              borderSide: new BorderSide(
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget showOptions() {
    return new Container(child:
      Column(
        children: <Widget>[
          new Row(
              children: <Widget>[
                new Radio(
                  groupValue: radioItem,
                  value: 'techValid',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
            new Text(
                'Techninė apžiūra galioja',
                style: new TextStyle(fontSize: 16.0),),
                Radio(
                  groupValue: radioItem,
                  value: 'techInvalid',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
                new  Text('Negalioja'),
              ]
          ),
          new Row(
              children: <Widget>[
                new Radio(
                  groupValue: radioItem,
                  value: 'techValid',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
                new Text(
                  'Transporto priemonė apgadinta',
                  style: new TextStyle(fontSize: 16.0),),
                Radio(
                  groupValue: radioItem,
                  value: 'techInvalid',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
                new  Text('Neapgadinta'),
              ]
          ),
          new Row(
              children: <Widget>[
                new Radio(
                  groupValue: radioItem,
                  value: 'techValid',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
                new Text(
                  'Eismo įvykiai nežinomi',
                  style: new TextStyle(fontSize: 16.0),),
                Radio(
                  groupValue: radioItem,
                  value: 'techInvalid',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
                new  Text('Žinomi'),
              ]
          ),
          new Row(
              children: <Widget>[
                new Radio(
                  groupValue: radioItem,
                  value: 'techValid',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
                new Text(
                  'Transporto priemonės trūkumai',
                  style: new TextStyle(fontSize: 16.0),),
                Radio(
                  groupValue: radioItem,
                  value: 'techInvalid',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
                new  Text('Nėra trūkumų'),
              ]
          ),
        ],
      )

    );
  }

  Widget showButtons() {
    return new Column(children: <Widget>[
      new RaisedButton(
        elevation: 5.0,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.blue,
        child: new Text( 'Patvirtinti',
            style: new TextStyle(fontSize: 20.0, color: Colors.white)),
        onPressed: null ,
      ),
      new RaisedButton(
        elevation: 5.0,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: new Text('Atšaukti',
            style: new TextStyle(fontSize: 20.0, color: Colors.white)),
        onPressed: null,
      )
    ]);
  }
}
