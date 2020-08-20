import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:transporto_registravimas/models/vehicle.dart';
import 'package:transporto_registravimas/models/contract.dart';
import 'dart:async';

class VehicleSellingPage extends StatefulWidget {
  VehicleSellingPage(this.selection);

  final String selection;

  @override
  State<StatefulWidget> createState() => new _VehicleSellingPage();
}

class _VehicleSellingPage extends State<VehicleSellingPage> {
  List<Vehicle> _vehicleList;
  Query _vehicleQuery;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final databaseReference = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final myController = TextEditingController();

  StreamSubscription<Event> _onVehicleChangedSubscription;
  StreamSubscription<Event> _onVehicleAddedSubscription;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print(widget.selection);
    _vehicleList = new List();

    _vehicleQuery = _database
        .reference()
        .child("vehicle")
        .orderByChild("vin")
        .equalTo(widget.selection);

    _onVehicleAddedSubscription =
        _vehicleQuery.onChildAdded.listen(onEntryAdded);
    _onVehicleChangedSubscription =
        _vehicleQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onVehicleAddedSubscription.cancel();
    _onVehicleChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _vehicleList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _vehicleList[_vehicleList.indexOf(oldEntry)] =
          Vehicle.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _vehicleList.add(Vehicle.fromSnapshot(event.snapshot));
    });
  }

  int tech;
  int broken;
  int incidents;
  int defects;

  bool brakesVal = false;
  bool wheelsVal = false;
  bool lightsVal = false;
  bool personsVal = false;
  bool gasVal = false;

  String price;
  String km;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Transporto priemonių registravimo elektroninė paslauga'),
      ),
      body: new ListView(
        children: <Widget>[
          showVehicle(),
          enterPriceField(),
          enterVehicleKm(),
          enterNumber(),
          enterEmail(),
          showOptions(),
          showButtons(),
        ],
      ),
    );
  }

  Widget showVehicle() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _vehicleList.length,
        itemBuilder: (BuildContext context, int index) {
          String vehicleId = _vehicleList[index].key;
          String name = _vehicleList[index].name;
          String registrationNr = _vehicleList[index].registrationNr;
          return Container(
            child: Column(
              key: Key(vehicleId),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0, top: 16),
                      child: Text(
                        name,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 35.0, top: 16),
                      child: Text(
                        registrationNr,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
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
          onChanged: (String value) {
            price = value;
          },
          keyboardType: TextInputType.number,
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
          onChanged: (String value) {
            km = value;
          },
          keyboardType: TextInputType.number,
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
              borderSide: new BorderSide(),
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
              borderSide: new BorderSide(),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget showOptions() {
    return new Column(
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Radio(
            groupValue: tech,
            value: 1,
            onChanged: (val) {
              setState(() {
                tech = val;
              });
            },
          ),
          Text(
            'Techninė apžiūra galioja',
            style: new TextStyle(fontSize: 16.0),
          ),
          Radio(
            groupValue: tech,
            value: 0,
            onChanged: (val) {
              setState(() {
                tech = val;
              });
            },
          ),
          Text('Negalioja'),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Radio(
            groupValue: broken,
            value: 1,
            onChanged: (val) {
              setState(() {
                broken = val;
              });
            },
          ),
          Text(
            'Transporto priemonė apgadinta',
            style: new TextStyle(fontSize: 16.0),
          ),
          Radio(
            groupValue: broken,
            value: 2,
            onChanged: (val) {
              setState(() {
                broken = val;
              });
            },
          ),
          Text('Neapgadinta'),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Radio(
            groupValue: incidents,
            value: 1,
            onChanged: (val) {
              setState(() {
                incidents = val;
              });
            },
          ),
          Text(
            'Eismo įvykiai nežinomi',
            style: new TextStyle(fontSize: 16.0),
          ),
          Radio(
            groupValue: incidents,
            value: 0,
            onChanged: (val) {
              setState(() {
                incidents = val;
              });
            },
          ),
          Text('Žinomi'),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Radio(
            groupValue: defects,
            value: 0,
            onChanged: (val) {
              setState(() {
                defects = val;
              });
              {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -40.0,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: CircleAvatar(
                                  child: Icon(Icons.close),
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            ),
                            showDefectsForm(),
                          ],
                        ),
                      );
                    });
              }
            },
          ),
          Text(
            'Transporto priemonė turi trūkumai',
            style: new TextStyle(fontSize: 16.0),
          ),
          Radio(
            groupValue: defects,
            value: 1,
            onChanged: (val) {
              setState(() {
                defects = val;
              });
            },
          ),
          Text('Nėra trūkumų'),
        ]),
      ],
    );
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
                sellCar(widget.selection, _vehicleList[0]);
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

  Widget showSnackBar(BuildContext context) {
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.lightBlue]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }
  }

  sellCar(String carVin, Vehicle vehicle) {
    print(price);
    print(km);
    vehicle.statusId = "Pardavimo procese";
    if (vehicle != null) {
      createAgreement(vehicle, price, km);

      _database
          .reference()
          .child("vehicle")
          .child(vehicle.key)
          .set(vehicle.toJson());
    }
    showAlertDialog(context);
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("Gerai"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Transporto priemonė parduota"),
      content: Text(
          "Transporto priemonės pardavimas įvyko sėkmingai. Pirkimo-Pardavimo sutartis nusiųsta pirkėjui."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget showDefectsForm() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return new Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Transporto priemonės trūkumai (tinkamą variantą pažymėti):',
            style: new TextStyle(fontSize: 20.0),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Checkbox(
            value: brakesVal,
            onChanged: (bool value) {
              if (brakesVal == false) {
                setState(() {
                  brakesVal = true;
                });
              } else if (brakesVal == true) {
                setState(() {
                  brakesVal = false;
                });
              }
            },
          ),
          Text(
            'stabdžių sistemos',
            style: new TextStyle(fontSize: 16.0),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Checkbox(
            value: wheelsVal,
            onChanged: (bool value) {
              if (wheelsVal == false) {
                setState(() {
                  wheelsVal = true;
                });
              } else if (wheelsVal == true) {
                setState(() {
                  wheelsVal = false;
                });
              }
            },
          ),
          Flexible(
              child: new Text(
            'vairo mechanizmo ir pakabos elementų',
            style: new TextStyle(fontSize: 16.0),
          )),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Checkbox(
            value: lightsVal,
            onChanged: (bool value) {
              if (lightsVal == false) {
                setState(() {
                  lightsVal = true;
                });
              } else if (lightsVal == true) {
                setState(() {
                  lightsVal = false;
                });
              }
            },
          ),
          Flexible(
              child: new Text(
            'apšvietimo ir ir šviesos signalizavimo įtaisų',
            style: new TextStyle(fontSize: 16.0),
          )),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Checkbox(
            value: personsVal,
            onChanged: (bool value) {
              if (personsVal == false) {
                setState(() {
                  personsVal = true;
                });
              } else if (personsVal == true) {
                setState(() {
                  personsVal = false;
                });
              }
            },
          ),
          Text(
            'vairuotojo ir keleivių saugos sistemų',
            style: new TextStyle(fontSize: 16.0),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Checkbox(
            value: gasVal,
            onChanged: (bool value) {
              if (gasVal == false) {
                setState(() {
                  gasVal = true;
                });
              } else if (gasVal == true) {
                setState(() {
                  gasVal = false;
                });
              }
            },
          ),
          Flexible(
              child: new Text(
            'dujų išmetimo sistemos',
            style: new TextStyle(fontSize: 16.0),
          )),
        ]),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Informacija apie įvykius ir trūkumus:',
                  style: new TextStyle(fontSize: 20.0),
                ),
              ]),
        ),
        Container(
          width: 230,
          constraints: BoxConstraints(minWidth: 250.0, minHeight: 50.0),
          child: TextField(
            controller: myController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
        Row(
          children: <Widget>[
            MaterialButton(
              height: 40.0,
              minWidth: 280.0,
              color: Colors.white54,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Išsaugoti'),
            ),
          ],
        ),
      ]);
    });
  }

  createAgreement(Vehicle vehicle, var price, var km) {
    databaseReference
        .child("contract")
        .child(vehicle.registrationCertificateNr)
        .set({
      "carID": vehicle.key,
      "vin": vehicle.vin,
      "sellerID": vehicle.userId,
      "registrationCertificateNr": vehicle.registrationCertificateNr,
      "date": 'DateTime.now()',
      "location": 'Vilnius',
      "price": price,
      "km": km,
    });
  }
}
